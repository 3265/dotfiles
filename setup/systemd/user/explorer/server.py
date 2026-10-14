#!/usr/bin/env python3
import ast
import datetime
import html
import io
import json
import mimetypes
import os
import re
import subprocess
import urllib.parse
import zipfile
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = 6003
MAX_UPLOAD_BYTES = 1024 ** 3  # 1GB

IMAGE_EXTS = {".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg", ".bmp"}

# Extension -> pandoc/skylighting language name, for viewing non-.md text
# files with the same syntax highlighting as code blocks inside a .md file.
# Unlisted extensions just render as plain (unhighlighted) text.
LANG_BY_EXT = {
    ".py": "python", ".sh": "bash", ".bash": "bash", ".fish": "fish",
    ".js": "javascript", ".ts": "typescript", ".json": "json",
    ".yaml": "yaml", ".yml": "yaml", ".toml": "toml", ".html": "html",
    ".css": "css", ".c": "c", ".h": "c", ".cpp": "cpp", ".hpp": "cpp",
    ".rs": "rust", ".go": "go", ".rb": "ruby", ".java": "java",
    ".sql": "sql", ".xml": "xml", ".ini": "ini", ".conf": "ini",
    ".kdl": "", ".txt": "",
}

# Registered browse roots: {name: absolute path}, persisted to disk so new
# roots survive a service restart. Registered from the top page's form
# rather than hardcoded, since this is meant to serve more than one project.
# ~/.local/state (XDG_STATE_HOME), not ~/.config - this is app-managed
# state generated through the web UI, not hand-edited configuration.
CONFIG_DIR = os.path.expanduser("~/.local/state/pandoc-md-explorer")
ROOTS_FILE = os.path.join(CONFIG_DIR, "roots.json")
AUDIT_FILE = os.path.join(CONFIG_DIR, "audit.jsonl")
AUDIT_MAX_SHOWN = 500


def log_audit(action, root_name, rel):
    os.makedirs(CONFIG_DIR, exist_ok=True)
    entry = {"time": datetime.datetime.now().isoformat(timespec="seconds"),
             "action": action, "root": root_name, "path": rel}
    with open(AUDIT_FILE, "a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")


def load_audit():
    try:
        with open(AUDIT_FILE, encoding="utf-8") as f:
            lines = f.readlines()
    except OSError:
        return []
    entries = []
    for line in lines[-AUDIT_MAX_SHOWN:]:
        try:
            entries.append(json.loads(line))
        except json.JSONDecodeError:
            continue
    entries.reverse()
    return entries

# The only pandoc feature this needs is markdown->HTML + syntax highlighting;
# bundling linked .md files is simple enough to do ourselves (see
# bundle()/LINK_RE below) and keeps the source files in plain, portable
# markdown link syntax instead of a pandoc-only directive.
PANDOC = "/usr/bin/pandoc"

# Just the syntax-highlighting slice of `pandoc -s --highlight-style=breezedark`'s
# generated CSS (the sourceCode/span rules) - the rest of the page styling is ours.
HIGHLIGHT_CSS = """
pre > code.sourceCode { white-space: pre; position: relative; }
pre > code.sourceCode > span { line-height: 1.25; }
pre > code.sourceCode > span:empty { height: 1.2em; }
.sourceCode { overflow: visible; background-color: transparent; }
code.sourceCode > span { color: inherit; text-decoration: inherit; }
div.sourceCode { margin: 1em 0; }
pre.sourceCode { margin: 0; }
div.sourceCode { color: #cfcfc2; background-color: #232629; }
code span { color: #cfcfc2; }
code span.al { color: #95da4c; background-color: #4d1f24; font-weight: bold; }
code span.an { color: #3f8058; }
code span.at { color: #2980b9; }
code span.bn { color: #f67400; }
code span.bu { color: #7f8c8d; }
code span.cf { color: #fdbc4b; font-weight: bold; }
code span.ch { color: #3daee9; }
code span.cn { color: #27aeae; font-weight: bold; }
code span.co { color: #7a7c7d; }
code span.cv { color: #7f8c8d; }
code span.do { color: #a43340; }
code span.dt { color: #2980b9; }
code span.dv { color: #f67400; }
code span.er { color: #da4453; text-decoration: underline; }
code span.ex { color: #0099ff; font-weight: bold; }
code span.fl { color: #f67400; }
code span.fu { color: #8e44ad; }
code span.im { color: #27ae60; }
code span.in { color: #c45b00; }
code span.kw { color: #cfcfc2; font-weight: bold; }
code span.op { color: #cfcfc2; }
code span.ot { color: #27ae60; }
code span.pp { color: #27ae60; }
code span.re { color: #2980b9; background-color: #153042; }
code span.sc { color: #3daee9; }
code span.ss { color: #da4453; }
code span.st { color: #f44f4f; }
code span.va { color: #27aeae; }
code span.vs { color: #da4453; }
code span.wa { color: #da4453; }
"""

# execCommand('copy') instead of navigator.clipboard - the latter needs a
# secure context (HTTPS or localhost), which a plain-HTTP LAN IP is not.
COPY_JS = """
function copyToClipboard(text){
  var ta=document.createElement('textarea');
  ta.value=text;
  ta.style.position='fixed';
  ta.style.opacity='0';
  document.body.appendChild(ta);
  ta.focus();ta.select();
  try{document.execCommand('copy');}catch(e){}
  document.body.removeChild(ta);
}
function setAllChecked(checked){
  var boxes=document.getElementById('export-form').querySelectorAll('input[type=checkbox]');
  Array.prototype.forEach.call(boxes,function(c){c.checked=checked;});
  updateExportTotal();
}
function formatSize(n){
  if(n<1024)return n+'B';
  if(n<1024*1024)return (n/1024).toFixed(1)+'KB';
  return (n/1024/1024).toFixed(1)+'MB';
}
function updateExportTotal(){
  var form=document.getElementById('export-form');
  var bytes=parseInt(form.dataset.baseBytes,10)||0;
  var boxes=form.querySelectorAll('input[type=checkbox]:checked');
  if(form.dataset.sizeOnly==='1'){
    Array.prototype.forEach.call(boxes,function(c){bytes+=parseInt(c.dataset.bytes,10)||0;});
    document.getElementById('export-total').textContent='total: '+formatSize(bytes);
    return;
  }
  var lines=parseInt(form.dataset.baseLines,10)||0;
  var chars=parseInt(form.dataset.baseChars,10)||0;
  Array.prototype.forEach.call(boxes,function(c){
    lines+=parseInt(c.dataset.lines,10)||0;
    chars+=parseInt(c.dataset.chars,10)||0;
    bytes+=parseInt(c.dataset.bytes,10)||0;
  });
  document.getElementById('export-total').textContent=
    'total: '+lines+' lines, '+chars+' chars, '+formatSize(bytes);
}
function collectIncluded(formId){
  var boxes=document.getElementById(formId).querySelectorAll('input[type=checkbox]:checked');
  return Array.prototype.map.call(boxes,function(c){return encodeURIComponent(c.value);}).join(',');
}
function exportCopy(url,formId,btn){
  fetch(url+'?include='+collectIncluded(formId)+'&action=copy').then(function(r){return r.text();}).then(function(t){
    copyToClipboard(t);
    var orig=btn.textContent;
    btn.textContent='copied!';
    setTimeout(function(){btn.textContent=orig;},1200);
  });
}
function exportDownload(url,formId,filename,extraQuery){
  var a=document.createElement('a');
  a.href=url+'?include='+collectIncluded(formId)+(extraQuery||'');
  a.download=filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
}
function showFullTime(span,e){
  e.stopPropagation();
  if(!span.dataset.full)return;
  var old=document.querySelector('.mtime-popup');
  if(old)old.remove();
  var rect=span.getBoundingClientRect();
  var pop=document.createElement('div');
  pop.className='mtime-popup';
  pop.textContent=span.dataset.full;
  pop.style.left=rect.left+'px';
  pop.style.top=(rect.bottom+4)+'px';
  document.body.appendChild(pop);
  setTimeout(function(){pop.remove();},2000);
}
function sortKey(row,col){
  var cell=row.cells[col];
  if(col===3){
    var span=cell.querySelector('.mtime');
    return span?span.dataset.full:'';
  }
  if(col===2)return parseFloat(cell.textContent)||0;
  return cell.textContent.trim().toLowerCase();
}
function applySort(table,col,dir){
  var tbody=table.tBodies[0];
  var rows=Array.prototype.slice.call(tbody.rows);
  var pin=rows.filter(function(r){return r.classList.contains('pin');});
  var rest=rows.filter(function(r){return !r.classList.contains('pin');});
  rest.sort(function(a,b){
    var ka=sortKey(a,col),kb=sortKey(b,col);
    if(ka<kb)return dir==='asc'?-1:1;
    if(ka>kb)return dir==='asc'?1:-1;
    return 0;
  });
  pin.concat(rest).forEach(function(r){tbody.appendChild(r);});
  var arrows=table.querySelectorAll('th .sort-arrow');
  Array.prototype.forEach.call(arrows,function(s){s.textContent='';});
  arrows[col].textContent=dir==='asc'?' ↑':' ↓';
}
function sortTable(col){
  var table=document.getElementById('listing-table');
  if(!table)return;
  var saved=null;
  try{saved=JSON.parse(localStorage.getItem('explorer-sort')||'null');}catch(e){}
  var dir=(saved&&saved.col===col&&saved.dir==='asc')?'desc':'asc';
  try{localStorage.setItem('explorer-sort',JSON.stringify({col:col,dir:dir}));}catch(e){}
  applySort(table,col,dir);
}
function initSort(){
  var table=document.getElementById('listing-table');
  if(!table)return;
  var saved=null;
  try{saved=JSON.parse(localStorage.getItem('explorer-sort')||'null');}catch(e){}
  if(saved)applySort(table,saved.col,saved.dir);
}
window.addEventListener('DOMContentLoaded',initSort);
function showUploadModal(){
  var m=document.getElementById('upload-modal');
  if(m)m.classList.add('open');
}
function hideUploadModal(){
  var m=document.getElementById('upload-modal');
  if(m)m.classList.remove('open');
}
function openImagePopup(src){
  document.getElementById('image-modal-img').src=src;
  document.getElementById('image-modal').classList.add('open');
}
function closeImagePopup(){
  document.getElementById('image-modal').classList.remove('open');
}
function bindDocImages(){
  document.querySelectorAll('.doc img').forEach(function(img){
    img.onclick=function(){openImagePopup(img.src);};
  });
}
window.addEventListener('DOMContentLoaded',bindDocImages);
var suggestTimer=null;
function hideSuggestions(){
  var list=document.getElementById('path-suggestions');
  if(list){list.innerHTML='';list.style.display='none';}
}
function suggestPaths(input){
  clearTimeout(suggestTimer);
  suggestTimer=setTimeout(function(){
    fetch('/roots/suggest?q='+encodeURIComponent(input.value)).then(function(r){return r.json();}).then(function(paths){
      var list=document.getElementById('path-suggestions');
      if(!list)return;
      list.innerHTML='';
      if(!paths.length){list.style.display='none';return;}
      paths.forEach(function(p){
        var item=document.createElement('div');
        item.textContent=p;
        item.onmousedown=function(){input.value=p;hideSuggestions();};
        list.appendChild(item);
      });
      list.style.display='block';
    });
  },200);
}
function appendExportRow(path,size){
  var table=document.getElementById('export-table');
  if(!table)return;
  var tr=document.createElement('tr');
  var tdCheck=document.createElement('td');
  var cb=document.createElement('input');
  cb.type='checkbox';cb.checked=true;cb.value=path;cb.dataset.bytes=size;
  cb.onchange=updateExportTotal;
  tdCheck.appendChild(cb);
  var tdName=document.createElement('td');tdName.textContent=path;
  var tdSize=document.createElement('td');tdSize.textContent=formatSize(size);
  tr.appendChild(tdCheck);tr.appendChild(tdName);tr.appendChild(tdSize);
  table.appendChild(tr);
}
function loadExportDir(root,rel){
  var progress=document.getElementById('export-progress');
  fetch('/export-list/'+root+'/'+rel).then(function(r){return r.json();}).then(function(files){
    if(!files.length){
      if(progress)progress.textContent='(no files)';
      updateExportTotal();
      return;
    }
    var i=0,batchSize=30;
    function next(){
      if(i>=files.length){
        if(progress)progress.textContent=files.length+' files';
        updateExportTotal();
        return;
      }
      var batch=files.slice(i,i+batchSize);
      i+=batchSize;
      if(progress)progress.textContent='loading... ('+i+'/'+files.length+')';
      fetch('/export-meta/'+root+'?files='+batch.map(encodeURIComponent).join(',')).then(function(r){return r.json();}).then(function(metas){
        metas.forEach(function(m){appendExportRow(m.path,m.size);});
        updateExportTotal();
        next();
      });
    }
    next();
  });
}
"""

PAGE = """<!doctype html>
<html><head><meta charset="utf-8"><title>{title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>body{{font-family:monospace;background:#111;color:#eee;font-size:16px;margin:0;padding:8px;overflow-wrap:anywhere}}
table{{border-collapse:collapse;width:100%}}
td,th{{padding:8px 10px;border-bottom:1px solid #333;text-align:left;word-break:break-all}}
#listing-table th{{cursor:pointer;white-space:nowrap}}
#listing-table th:last-child,#listing-table td:last-child{{width:1%;white-space:nowrap;cursor:default}}
#listing-table td{{padding-bottom:12px}}
.sort-arrow{{color:#6cf}}
a{{color:#6cf}}
.file-link{{text-decoration:none}}
.file-link small{{text-decoration:none}}
a.dir-link{{color:#e8b339;font-weight:bold;text-decoration:none}}
.mtime{{cursor:pointer;border-bottom:1px dotted #666;white-space:nowrap}}
.mtime-popup{{position:fixed;background:#222;border:1px solid #555;border-radius:4px;padding:4px 8px;font-size:13px;z-index:100;white-space:nowrap}}
input[type=text]{{background:#1a1a1a;color:#eee;border:1px solid #555;border-radius:4px;padding:6px 8px;font-family:monospace;box-sizing:border-box}}
.add-root{{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:12px}}
.path-input-wrap{{position:relative;flex:1;min-width:200px}}
.path-input-wrap input{{width:100%;box-sizing:border-box}}
.suggest-list{{display:none;position:absolute;top:100%;left:0;right:0;background:#1a1a1a;
border:1px solid #444;border-radius:4px;max-height:200px;overflow-y:auto;z-index:50}}
.suggest-list div{{padding:6px 10px;cursor:pointer;word-break:break-all}}
.suggest-list div:hover{{background:#333}}
.upload-form{{display:flex;flex-wrap:wrap;gap:8px;margin-top:8px}}
.upload-form input[type=file]{{max-width:100%}}
.modal-overlay{{display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:200;align-items:center;justify-content:center}}
.modal-overlay.open{{display:flex}}
.modal-box{{box-sizing:border-box;background:#1a1a1a;border:1px solid #444;border-radius:8px;padding:20px;max-width:90%;width:320px}}
#image-modal img{{max-width:95vw;max-height:95vh;object-fit:contain}}
.doc img{{cursor:zoom-in}}
img.thumb{{max-height:40px;max-width:120px;cursor:zoom-in;vertical-align:middle;display:block}}
button.copy,a.copy,button.submit{{box-sizing:border-box;vertical-align:middle;line-height:20px;background:#333;color:#eee;border:1px solid #555;border-radius:4px;padding:4px 10px;font-family:monospace;cursor:pointer;text-decoration:none;display:inline-block}}
button.kill{{background:#511;color:#fbb;border:1px solid #733;border-radius:4px;padding:4px 10px;font-family:monospace;cursor:pointer}}
.export-actions{{margin-top:20px;display:flex;flex-wrap:wrap;gap:12px}}
.doc{{font-family:sans-serif;line-height:1.6;max-width:900px;margin:0 auto}}
#title-block-header{{margin-top:0}}
#title-block-header h1{{margin:16px 0 20px;border-left:none;padding-left:0;font-family:monospace;font-size:1.6em;font-weight:bold;line-height:normal}}
.page-title{{font-family:monospace;font-size:1.6em;font-weight:bold;margin:16px 0 20px;line-height:normal}}
.doc h1,.doc h2,.doc h3,.doc h4,.doc h5,.doc h6{{position:relative}}
.doc h1::after,.doc h2::after,.doc h3::after,.doc h4::after,.doc h5::after,.doc h6::after{{position:absolute;top:2px;right:0;font-weight:normal;font-family:monospace;font-size:0.6em;color:#666}}
.doc h1{{font-size:1.7em;font-weight:bold;color:#fff;border-left:6px solid #6cf;padding-left:12px;margin-top:1.8em}}
.doc h1::after{{content:"H1"}}
.doc h2{{font-size:1.35em;font-weight:bold;color:#dfefff;border-left:5px solid #6cf;padding-left:10px;margin-top:1.6em}}
.doc h2::after{{content:"H2"}}
.doc h3{{font-size:1.15em;font-weight:bold;color:#bcd;border-left:4px solid #478;padding-left:9px;margin-top:1.3em}}
.doc h3::after{{content:"H3"}}
.doc h4{{font-size:1.05em;font-weight:bold;color:#9bd;border-left:3px solid #357;padding-left:8px;margin-top:1.1em}}
.doc h4::after{{content:"H4"}}
.doc h5{{font-size:1em;font-weight:bold;color:#8ac;border-left:2px solid #246;padding-left:7px;margin-top:1em}}
.doc h5::after{{content:"H5"}}
.doc h6{{font-size:0.95em;font-weight:bold;color:#79b;border-left:2px solid #135;padding-left:6px;text-transform:uppercase;letter-spacing:0.04em;margin-top:1em}}
.doc h6::after{{content:"H6"}}
.doc blockquote{{border-left:4px solid #555;background:#1a1a1a;margin:1em 0;padding:4px 16px;color:#bbb}}
.doc hr{{border:none;border-top:2px solid #444;margin:2em 0}}
.doc pre{{background:#1a1a1a;padding:8px;overflow-x:auto}}
.doc code{{background:#1a1a1a;padding:2px 4px}}
.doc pre code{{background:transparent;padding:0}}
.doc-table-wrap{{overflow-x:auto;margin:1em 0}}
.doc-table-wrap table{{width:100%;table-layout:fixed;border:1px solid #333}}
.doc-table-wrap td,.doc-table-wrap th{{word-break:normal;overflow-wrap:break-word;min-width:100px;border:1px solid #333}}
.doc-table-wrap th{{background:#1d1d1d;font-weight:bold}}
.doc-table-wrap tr:nth-child(even) td{{background:#161616}}
nav:empty{{display:none}}
nav{{display:flex;flex-wrap:wrap;border-bottom:2px solid #333;margin:0 0 16px}}
nav a{{padding:8px 16px;border:none;border-bottom:2px solid transparent;margin-bottom:-2px;color:#888;text-decoration:none}}
nav a.active{{color:#6cf;border-bottom-color:#6cf}}
nav a:hover{{color:#eee}}
.menu-bar{{margin-bottom:12px;display:flex;flex-wrap:wrap;justify-content:space-between;align-items:center;gap:8px}}
.menu-right{{display:flex;flex-wrap:wrap;gap:8px}}
.file-stats{{color:#888;font-size:13px;margin:0 0 12px}}
#export-total{{margin-top:16px}}
.menu-label{{color:#888;font-size:13px;align-self:center}}
#TOC{{background:#1a1a1a;border:1px solid #333;border-radius:4px;padding:12px 20px;margin-bottom:1.5em}}
#TOC ul{{margin:0}}
{highlight_css}</style>
<script>{copy_js}</script>{extra_head}</head>
<body><nav>{nav}</nav>{body}
<div id="image-modal" class="modal-overlay" onclick="closeImagePopup()"><img id="image-modal-img" src=""></div>
</body></html>"""

# Pinned CDN versions - only loaded on pages that actually need them (math
# and diagrams are rare enough, and MathJax/Mermaid heavy enough, that
# every other page shouldn't pay for them).
MATH_MERMAID_HEAD = """
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true,theme:'dark'});</script>
"""


def render_page(title, nav, body, extra_head=""):
    return PAGE.format(title=title, nav=nav, body=body, highlight_css=HIGHLIGHT_CSS,
                        copy_js=COPY_JS, extra_head=extra_head)


TRASH_DIR = os.path.expanduser("~/.local/share/Trash/files")


def load_roots():
    try:
        with open(ROOTS_FILE, encoding="utf-8") as f:
            roots = json.load(f)
    except (OSError, json.JSONDecodeError):
        roots = {}
    # Always present, not something the "add root" form needs to know about
    # - this is where delete_file()'s `gio trash` actually puts things, so
    # browsing it is how a mistaken delete gets undone.
    if "trash" not in roots:
        os.makedirs(TRASH_DIR, exist_ok=True)
        roots["trash"] = TRASH_DIR
        save_roots(roots)
    return roots


def save_roots(roots):
    os.makedirs(CONFIG_DIR, exist_ok=True)
    with open(ROOTS_FILE, "w", encoding="utf-8") as f:
        json.dump(roots, f, ensure_ascii=False, indent=2)


def parse_multipart_file(body, boundary):
    """(filename, data) for the "file" field of a single-file
    multipart/form-data upload, or None if not present. Doesn't use the
    stdlib cgi module since it's deprecated/removed from Python 3.13."""
    for part in body.split(b"--" + boundary.encode()):
        if b'name="file"' not in part:
            continue
        header_end = part.find(b"\r\n\r\n")
        if header_end == -1:
            continue
        headers = part[:header_end].decode(errors="replace")
        content = part[header_end + 4:]
        if content.endswith(b"\r\n"):
            content = content[:-2]
        m = re.search(r'filename="([^"]*)"', headers)
        if m and m.group(1):
            return os.path.basename(m.group(1)), content
    return None


def suggest_paths(partial):
    """Absolute directory paths matching what's typed so far in the "add
    root" form, for live autocomplete (e.g. "/mnt/data4tb/pro" -> lists
    dirs under /mnt/data4tb/ starting with "pro")."""
    if not partial:
        base, prefix = "/", ""
    elif partial.endswith("/"):
        base, prefix = partial, ""
    else:
        base, prefix = os.path.dirname(partial) or "/", os.path.basename(partial)
    try:
        entries = sorted(os.listdir(base))
    except OSError:
        return []
    out = []
    for name in entries:
        if name.startswith(".") or not name.lower().startswith(prefix.lower()):
            continue
        full = os.path.join(base, name)
        if os.path.isdir(full):
            out.append(full)
    return out[:20]


def add_root(path):
    path = os.path.normpath(path)
    if not os.path.isdir(path):
        return False
    roots = load_roots()
    name = os.path.basename(path.rstrip("/")) or path
    base_name = name
    i = 2
    while name in roots and roots[name] != path:
        name = f"{base_name}-{i}"
        i += 1
    roots[name] = path
    save_roots(roots)
    return True


def split_root(rel):
    """'<root>/<rest...>' -> (root_name, rest) ; (root_name, '') if no rest."""
    rel = rel.lstrip("/")
    root_name, _, rest = rel.partition("/")
    return root_name, rest


def safe_path(root_name, rel):
    root = load_roots().get(root_name)
    if not root:
        return None
    rel = rel.lstrip("/")
    target = os.path.normpath(os.path.join(root, rel))
    if target != root and not target.startswith(root + os.sep):
        return None
    return target


def mountpoint_of(path):
    path = os.path.abspath(path)
    dev = os.stat(path).st_dev
    while True:
        parent = os.path.dirname(path)
        if parent == path or os.stat(parent).st_dev != dev:
            return path
        path = parent


def trash_location(path):
    """Where delete_file()'s `gio trash` will actually put this path - the
    home trash dir if it's on the same filesystem as $HOME, otherwise that
    other filesystem's own .Trash-<uid> (the freedesktop trash spec keeps
    the trash on the same filesystem as the file, e.g. everything under a
    /mnt or /media root lands in its own mountpoint's trash, not the one
    the "trash" root shows)."""
    if os.stat(path).st_dev == os.stat(os.path.expanduser("~")).st_dev:
        return TRASH_DIR
    return os.path.join(mountpoint_of(path), f".Trash-{os.getuid()}", "files")


def delete_file(root_name, rel):
    """Moves exactly one file to the desktop trash (gio trash, same place
    the file manager's trash shows and can restore from, with the correct
    per-mountpoint .Trash-<uid> when the root lives on another filesystem)
    - never a permanent os.remove(). Directories are refused here (not just
    hidden from the listing's delete button) so a crafted request can't
    walk the server into trashing a whole folder."""
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target) or os.path.isdir(target):
        return False
    result = subprocess.run(["gio", "trash", target], capture_output=True)
    if result.returncode == 0:
        log_audit("delete", root_name, rel)
        return True
    return False


# Plain markdown links to a local file, e.g. [text](other.md) or
# [text](../script.py). Links elsewhere (http(s), mailto, anchors) are left
# untouched - EXTERNAL_LINK_RE below filters those out.
LINK_RE = re.compile(r'\[([^\]]*)\]\(([^)\s]+)\)')
EXTERNAL_LINK_RE = re.compile(r'^(?:[a-zA-Z][a-zA-Z0-9+.-]*:|#)')

# Three stacked "---" lines render as three <hr>s in a row - a document
# would essentially never do that on its own, so it reads as a deliberate
# divider instead of blending into a quoted file's own single "---" rules.
SEP = "---\n---\n---"


def resolve_link(root, current_dir, link_path):
    """abs path for a local, non-binary file link target, or None if it's
    external (http(s)/mailto/anchor), a directory, outside root, or binary
    (can't usefully be quoted as text either way)."""
    if EXTERNAL_LINK_RE.match(link_path):
        return None
    abs_path = os.path.normpath(os.path.join(current_dir, link_path))
    if abs_path != root and not abs_path.startswith(root + os.sep):
        return None
    if not os.path.isfile(abs_path) or is_probably_binary(abs_path):
        return None
    return abs_path


def wrap_as_code(ext, content):
    lang = LANG_BY_EXT.get(ext, "")
    fence = "````"
    return f"{fence}{lang}\n{content}\n{fence}\n"


def file_size(path):
    try:
        return os.path.getsize(path)
    except OSError:
        return 0


def human_size(n):
    for unit in ("B", "KB", "MB"):
        if n < 1024 or unit == "MB":
            return f"{n:.0f}{unit}" if unit == "B" else f"{n:.1f}{unit}"
        n /= 1024


def fmt_count(n):
    """count_lines/count_chars return None for files too big to safely
    read in full - show that as "-" instead of the literal "None"."""
    return str(n) if n is not None else "-"


def linked_files(root_name, target):
    """(root-relative path, line count, char count, byte size) for the
    local text files target plain-links to (dedup, one level - same set
    bundle() would expand with include=None)."""
    root = load_roots().get(root_name)
    with open(target, encoding="utf-8") as f:
        text = f.read()
    current_dir = os.path.dirname(target)
    seen = []
    rels = set()
    for m in LINK_RE.finditer(text):
        abs_path = resolve_link(root, current_dir, m.group(2))
        if abs_path:
            rel = os.path.relpath(abs_path, root)
            if rel not in rels:
                rels.add(rel)
                seen.append((rel, count_lines(abs_path), count_chars(abs_path), file_size(abs_path)))
    return seen


def bundle(root_name, target, include=None):
    """Read target as-is (links just get their href rewritten, body
    untouched) and append any local text files it plain-links to at the
    bottom, one level deep (links found inside those linked files are not
    followed further). Keeping the original content undisturbed up top,
    with quoted files clearly separated below, beats interleaving them
    inline - there's no good way to mark "this is where the quoted file
    ends and the original resumes" without a reader having to think about
    it. Non-.md files are wrapped as a fenced code block (same as the
    viewer) rather than inserted raw, since they aren't markdown prose.

    include: if given, a set of root-relative paths - only those linked
    files are appended (links are always rewritten either way; this only
    controls which ones get their content pulled in), for the export page's
    pick-what-to-include flow."""
    root = load_roots().get(root_name)
    with open(target, encoding="utf-8") as f:
        text = f.read()
    current_dir = os.path.dirname(target)
    appendix = []
    seen = set()

    def repl(m):
        link_text, link_path = m.group(1), m.group(2)
        abs_path = resolve_link(root, current_dir, link_path)
        if abs_path is None:
            return m.group(0)  # external, binary, or outside root - leave as-is
        rel_to_root = os.path.relpath(abs_path, root)
        rewritten = f'[{link_text}](/view/{root_name}/{urllib.parse.quote(rel_to_root)})'
        if abs_path in seen or (include is not None and rel_to_root not in include):
            return rewritten
        seen.add(abs_path)
        try:
            with open(abs_path, encoding="utf-8") as f:
                included = f.read()
        except OSError as e:
            included = f'*(could not include: {e})*'
        else:
            ext = os.path.splitext(abs_path)[1].lower()
            if ext != ".md":
                included = wrap_as_code(ext, included)
        appendix.append(f"## \U0001F4C4 {rel_to_root}\n\n{included}")
        return rewritten

    main = LINK_RE.sub(repl, text)
    if not appendix:
        return main
    return main + f"\n\n{SEP}\n\n# \U0001F4CE quoted files\n\n" + f"\n\n{SEP}\n\n".join(appendix) + "\n"


MAX_COUNT_BYTES = 5 * 1024 * 1024  # don't read huge (e.g. GB-sized data) files just to count lines/chars


def count_lines(path):
    try:
        if os.path.getsize(path) > MAX_COUNT_BYTES:
            return None
        with open(path, "rb") as f:
            return sum(1 for _ in f)
    except OSError:
        return 0


def count_chars(path):
    try:
        if os.path.getsize(path) > MAX_COUNT_BYTES:
            return None
        with open(path, encoding="utf-8", errors="replace") as f:
            return len(f.read())
    except OSError:
        return 0


def count_files(path):
    total = 0
    for dirpath, dirnames, filenames in os.walk(path):
        dirnames[:] = [d for d in dirnames if not d.startswith(".")]
        total += sum(1 for f in filenames if not f.startswith("."))
    return total


def mtime_info(path):
    """(compact relative age, full ISO timestamp). The compact form ("5d",
    "3h") is mostly 2 chars since there isn't room for a full timestamp in
    this column - the ISO one is shown on tap instead (see showFullTime())."""
    try:
        ts = os.path.getmtime(path)
    except OSError:
        return "", ""
    age = max(0, datetime.datetime.now().timestamp() - ts)
    if age < 60:
        disp = f"{int(age)}s"
    elif age < 3600:
        disp = f"{int(age // 60)}m"
    elif age < 86400:
        disp = f"{int(age // 3600)}h"
    elif age < 86400 * 30:
        disp = f"{int(age // 86400)}d"
    elif age < 86400 * 365:
        disp = f"{int(age // (86400 * 30))}mo"
    else:
        disp = f"{int(age // (86400 * 365))}y"
    iso = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%dT%H:%M")
    return disp, iso


def is_probably_binary(path):
    try:
        with open(path, "rb") as f:
            chunk = f.read(8192)
        return b"\x00" in chunk
    except OSError:
        return True


def extract_h1(path):
    """First "# heading" line's text, if the file has one within its first
    20 lines - filenames here (msg_003_..., etc.) are often cryptic, while
    the doc's own H1 says what it's actually about."""
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            for _ in range(20):
                line = f.readline()
                if not line:
                    break
                line = line.strip()
                if line.startswith("# "):
                    return line[2:].strip()
    except OSError:
        pass
    return None


def extract_py_summary(path, limit=100):
    """First line of the module docstring, truncated - same idea as
    extract_h1() but for .py files, whose filenames are just as terse."""
    try:
        if os.path.getsize(path) > MAX_COUNT_BYTES:
            return None
        with open(path, encoding="utf-8", errors="replace") as f:
            src = f.read()
        doc = ast.get_docstring(ast.parse(src))
    except (OSError, SyntaxError, ValueError):
        return None
    if not doc:
        return None
    first_line = doc.strip().splitlines()[0].strip()
    if len(first_line) > limit:
        first_line = first_line[:limit].rstrip() + "..."
    return first_line


def python_toc(source):
    """Top-level defs/classes (and each class's methods) as (lineno, label,
    methods) triples, methods being the same (lineno, label) shape one
    level down - mirrors a markdown TOC's role for a .py file that has no
    headings of its own to build one from."""
    try:
        tree = ast.parse(source)
    except SyntaxError:
        return []
    items = []
    for node in tree.body:
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            items.append((node.lineno, f"{node.name}()", []))
        elif isinstance(node, ast.ClassDef):
            methods = [(n.lineno, f"{n.name}()") for n in node.body
                       if isinstance(n, (ast.FunctionDef, ast.AsyncFunctionDef))]
            items.append((node.lineno, node.name, methods))
    return items


def render_python_toc(items, cb_id="cb1"):
    if not items:
        return ""
    parts = ['<nav id="TOC" role="doc-toc"><ul>']
    for lineno, label, methods in items:
        parts.append(f'<li><a href="#{cb_id}-{lineno}">{html.escape(label)}</a>')
        if methods:
            parts.append("<ul>")
            parts.extend(f'<li><a href="#{cb_id}-{mline}">{html.escape(mlabel)}</a></li>'
                         for mline, mlabel in methods)
            parts.append("</ul>")
        parts.append("</li>")
    parts.append("</ul></nav>")
    return "".join(parts)


ROOT_TABS = [("/", "roots"), ("/audit", "audit")]


def render_root_nav(active):
    links = "".join(
        f'<a href="{href}"{" class=\"active\"" if href == active else ""}>{label}</a>'
        for href, label in ROOT_TABS
    )
    return f"<nav>{links}</nav>"


def render_audit():
    rows = "".join(
        f'<tr><td>{html.escape(e.get("time", "-"))}</td><td>{html.escape(e.get("action", "-"))}</td>'
        f'<td>{html.escape(e.get("root", "-"))}</td><td>{html.escape(e.get("path", "-"))}</td></tr>'
        for e in load_audit()
    )
    table = (f"<table><tr><th>time</th><th>action</th><th>root</th><th>path</th></tr>{rows}</table>"
             if rows else "<p>no activity logged yet</p>")
    heading = '<h1 class="page-title"><a href="/" style="text-decoration:none">&#x1F4C1;</a> audit log</h1>'
    nav = render_root_nav("/audit")
    return render_page("&#x1F4C1; explorer: audit", "", f"{heading}{nav}{table}")


def render_roots():
    roots = load_roots()
    rows = []
    for name, path in sorted(roots.items()):
        trash_hint = trash_location(path)
        trash_note = (f'<br><small style="color:#888">deleted files go to {html.escape(trash_hint)}</small>'
                      if trash_hint != TRASH_DIR else "")
        rows.append(
            f'<tr><td><a href="/browse/{urllib.parse.quote(name)}/">{html.escape(name)}</a></td>'
            f'<td>{html.escape(path)}{trash_note}</td>'
            f'<td><a href="/roots/remove/{urllib.parse.quote(name)}">remove</a></td></tr>'
        )
    table = (f"<table><tr><th>name</th><th>path</th><th></th></tr>{''.join(rows)}</table>"
             if rows else "<p>no roots registered yet</p>")
    form = """
<form method="post" action="/roots/add" class="add-root">
<div class="path-input-wrap">
<input type="text" name="path" id="path-input" placeholder="/absolute/path/to/project"
       autocomplete="off" oninput="suggestPaths(this)" onblur="setTimeout(hideSuggestions,150)">
<div id="path-suggestions" class="suggest-list"></div>
</div>
<button class="submit" type="submit">add root</button>
</form>
"""
    heading = '<h1 class="page-title"><a href="/" style="text-decoration:none">&#x1F4C1;</a> explorer</h1>'
    nav = render_root_nav("/")
    return render_page("&#x1F4C1; explorer", "", f"{heading}{nav}{form}{table}")


def render_listing(root_name, rel):
    target = safe_path(root_name, rel)
    if not target or not os.path.isdir(target):
        return None
    try:
        entries = sorted(os.listdir(target))
    except OSError:
        entries = []

    trash_hint = trash_location(target)
    trash_note = f" (moved to {trash_hint})" if trash_hint != TRASH_DIR else ""

    rows = []
    file_count = 0
    dir_count = 0
    for name in entries:
        if name.startswith("."):
            continue
        full = os.path.join(target, name)
        relpath = f"{rel}/{name}" if rel else name
        quoted = urllib.parse.quote(relpath)
        mtime_disp, mtime_iso = mtime_info(full)
        mtime_td = (f'<td><span class="mtime" data-full="{mtime_iso}" '
                    f'onclick="showFullTime(this,event)">{mtime_disp}</span></td>')
        if os.path.isdir(full):
            dir_count += 1
            sub_count = count_files(full)
            rows.append(f'<tr><td><a class="dir-link" href="/browse/{root_name}/{quoted}">{html.escape(name)}/</a></td><td>dir</td>'
                        f'<td>{sub_count}</td>{mtime_td}<td></td></tr>')
            continue
        delete_td = (f'<td><form method="post" action="/delete/{root_name}/{quoted}" style="margin:0" '
                     f'onsubmit="return confirm(\'delete {html.escape(name)}?{html.escape(trash_note)}\')">'
                     f'<button class="kill" type="submit" title="delete">&#x1F5D1;</button></form></td>')
        if name.lower().endswith(".md"):
            file_count += 1
            lines = fmt_count(count_lines(full))
            h1 = extract_h1(full)
            label = (f'{html.escape(h1)}'
                     f'<small style="color:#888;display:block;margin-top:4px">{html.escape(name)}</small>'
                     if h1 else html.escape(name))
            rows.append(f'<tr><td><a class="file-link" href="/view/{root_name}/{quoted}">{label}</a></td><td>md</td>'
                        f'<td>{lines}</td>{mtime_td}{delete_td}</tr>')
        elif name.lower().endswith(".py"):
            file_count += 1
            lines = fmt_count(count_lines(full))
            summary = extract_py_summary(full)
            label = (f'{html.escape(summary)}'
                     f'<small style="color:#888;display:block;margin-top:4px">{html.escape(name)}</small>'
                     if summary else html.escape(name))
            rows.append(f'<tr><td><a class="file-link" href="/view/{root_name}/{quoted}">{label}</a></td><td>text</td>'
                        f'<td>{lines}</td>{mtime_td}{delete_td}</tr>')
        elif os.path.splitext(name)[1].lower() in IMAGE_EXTS:
            file_count += 1
            src = f"/file/{root_name}/{quoted}"
            label = (f'<img class="thumb" src="{src}" loading="lazy" onclick="openImagePopup(this.src)">'
                     f'<small style="color:#888;display:block;margin-top:4px">{html.escape(name)}</small>')
            rows.append(f'<tr><td>{label}</td><td>img</td>'
                        f'<td>{human_size(file_size(full))}</td>{mtime_td}{delete_td}</tr>')
        elif name.lower().endswith(".pdf"):
            file_count += 1
            src = f"/file/{root_name}/{quoted}"
            rows.append(f'<tr><td><a class="file-link" href="{src}" target="_blank" rel="noopener">{html.escape(name)}</a></td><td>pdf</td>'
                        f'<td>{human_size(file_size(full))}</td>{mtime_td}{delete_td}</tr>')
        elif not is_probably_binary(full):
            file_count += 1
            lines = fmt_count(count_lines(full))
            rows.append(f'<tr><td><a class="file-link" href="/view/{root_name}/{quoted}">{html.escape(name)}</a></td><td>text</td>'
                        f'<td>{lines}</td>{mtime_td}{delete_td}</tr>')
        else:
            file_count += 1
            rows.append(f'<tr><td>{html.escape(name)}</td><td>bin</td><td></td>{mtime_td}{delete_td}</tr>')

    heading = f'<h1 class="page-title"><a href="/" style="text-decoration:none">&#x1F4C1;</a> {root_name}/{html.escape(rel)}</h1>'
    parent = os.path.dirname(rel.rstrip("/")) if rel else None
    back_href = f"/browse/{root_name}/{urllib.parse.quote(parent)}" if rel else "/"
    summary = f'<p class="file-stats">{file_count} files, {dir_count} folders here</p>'
    ths = "".join(
        f'<th onclick="sortTable({i})">{label}<span class="sort-arrow"></span></th>'
        for i, label in enumerate(("name", "type", "size", "mod"))
    ) + "<th></th>"
    upload_modal = f"""
<div id="upload-modal" class="modal-overlay" onclick="if(event.target===this)hideUploadModal()">
<div class="modal-box">
<h3>upload file</h3>
<form method="post" action="/upload/{root_name}/{urllib.parse.quote(rel)}" enctype="multipart/form-data" class="upload-form">
<input type="file" name="file" required>
<button class="submit" type="submit">upload</button>
<button type="button" class="submit" onclick="hideUploadModal()">cancel</button>
</form>
<p style="font-size:12px;color:#888">max 1GB</p>
</div>
</div>"""
    menu = (f'<div class="menu-bar">'
            f'<a class="copy" href="{back_href}">&larr; back</a>'
            f'<span class="menu-right">'
            f'<a class="copy" onclick="showUploadModal()" style="cursor:pointer">&#x2B06; upload</a>'
            f'<a class="copy" href="/export/{root_name}/{urllib.parse.quote(rel)}">&#x1F4E4; export</a>'
            f'</span></div>')
    body = (f'{heading}{menu}{summary}<table id="listing-table"><thead><tr>{ths}</tr></thead>'
            f'<tbody>{"".join(rows)}</tbody></table>{upload_modal}')
    return render_page(f"&#x1F4C1; explorer: {root_name}/{rel}", "", body)


def render_view(root_name, rel):
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target):
        return None

    ext = os.path.splitext(target)[1].lower()
    title_meta = f"--metadata=title=\U0001F4C1 {os.path.basename(target)}"
    raw = ""
    content = None

    if os.path.getsize(target) == 0:
        content = (f'<header id="title-block-header"><h1 class="title">'
                   f'\U0001F4C1 {html.escape(os.path.basename(target))}</h1></header>'
                   f'<p style="color:#888">(empty file)</p>')
    elif ext == ".md":
        # No link expansion here (just a plain render) - the
        # /view/<root>/<path> URL scheme mirrors the directory tree, so
        # relative links in the file already resolve to the right /view/
        # page on their own. Expansion only happens for the
        # copy-to-clipboard output (see bundle()/render_raw()).
        #
        # --toc only emits anything in -s/standalone mode (the TOC is part
        # of the page template, not injected into a bare fragment), so this
        # runs standalone and pulls just the <body> contents (TOC nav + doc)
        # back out rather than using pandoc's own <html>/<head> page shell.
        out = subprocess.run(
            [PANDOC, "-f", "gfm", "-t", "html", "-s", "--highlight-style", "breezedark",
             "--toc", "--toc-depth=3", "--mathjax", title_meta, target],
            capture_output=True, text=True,
        )
    else:
        # Non-markdown text files: wrap the whole file as one fenced code
        # block (language guessed from the extension) so it gets the same
        # syntax highlighting as a code block inside a .md file, instead of
        # being misinterpreted as markdown prose.
        try:
            with open(target, encoding="utf-8", errors="replace") as f:
                raw = f.read()
        except OSError as e:
            return render_page(f"&#x1F4C1; explorer: {os.path.basename(target)}", "", f"<pre>{html.escape(str(e))}</pre>")
        lang = LANG_BY_EXT.get(ext, "")
        fence = "````"
        # numberLines gives each line an id (cb1-N) that a .py TOC's links
        # can jump to - skipped for other languages so their view doesn't
        # grow a line-number gutter nobody asked for.
        info = f"{{.{lang} .numberLines}}" if ext == ".py" and lang else lang
        wrapped = f"{fence}{info}\n{raw}\n{fence}\n"
        out = subprocess.run(
            [PANDOC, "-f", "gfm", "-t", "html", "-s", "--highlight-style", "breezedark", title_meta],
            input=wrapped, capture_output=True, text=True,
        )

    if content is None:
        if out.returncode != 0:
            content = f"<pre>{html.escape(out.stderr)}</pre>"
        else:
            m = re.search(r"<body>\n?(.*)</body>", out.stdout, re.DOTALL)
            content = m.group(1) if m else out.stdout
            # Wrap each rendered markdown table so only the table scrolls
            # horizontally on mobile instead of the whole page, or cells
            # getting squished by the global word-break:break-all rule.
            content = re.sub(r"(<table>.*?</table>)", r'<div class="doc-table-wrap">\1</div>',
                              content, flags=re.DOTALL)

    # Make the leading folder emoji in the title a link back to the
    # explorer root, same as the other list/audit/export page headings.
    content = re.sub(r'(<h1 class="title">)(\U0001F4C1)',
                      r'\1<a href="/" style="text-decoration:none">\2</a>', content, count=1)

    parent = os.path.dirname(rel)
    quoted = urllib.parse.quote(rel)
    name = os.path.basename(target)
    stats = (f'<p class="file-stats">{fmt_count(count_lines(target))} lines, '
             f'{fmt_count(count_chars(target))} chars, {human_size(file_size(target))}</p>')
    menu = (f'<div class="menu-bar">'
            f'<a class="copy" href="/browse/{root_name}/{urllib.parse.quote(parent)}">&larr; back</a>'
            f'<span class="menu-right">'
            f'<a class="copy" href="/export/{root_name}/{quoted}">&#x1F4E4; export</a>'
            f'</span></div>{stats}')
    toc_html = render_python_toc(python_toc(raw)) if ext == ".py" else ""
    # pandoc's own title block (from --metadata=title=) renders the
    # filename as an <h1>, with the TOC right after it - put the menu
    # between the two instead of above everything, so it reads as
    # filename -> actions -> stats -> table of contents -> body.
    if "</header>" in content:
        content = content.replace("</header>", f"</header>{menu}{toc_html}", 1)
    else:
        content = menu + toc_html + content
    extra_head = MATH_MERMAID_HEAD if ext == ".md" else ""
    return render_page(f"&#x1F4C1; explorer: {os.path.basename(target)}", "", f'<div class="doc">{content}</div>', extra_head=extra_head)


def render_raw(root_name, rel, include=None):
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target):
        return None
    return bundle(root_name, target, include=include)


def walk_relpaths(target, root):
    """Root-relative path for every non-hidden file under target,
    recursively - just names, no stat/read per file, so this stays fast
    even in a folder with huge (multi-GB) data files in it."""
    out = []
    for dirpath, dirnames, filenames in os.walk(target):
        dirnames[:] = [d for d in dirnames if not d.startswith(".")]
        for fn in filenames:
            if fn.startswith("."):
                continue
            full = os.path.join(dirpath, fn)
            out.append(os.path.relpath(full, root))
    return sorted(out)


def build_zip(root_name, rel, include=None, expand_links=False):
    root = load_roots().get(root_name)
    target = safe_path(root_name, rel)
    if not target or not os.path.isdir(target):
        return None

    selected = {
        relpath for relpath in walk_relpaths(target, root)
        if include is None or relpath in include
    }
    if expand_links:
        # Depth-1 only, same convention as the single-file export's own
        # bundle() - a selected .md file's own linked docs get pulled in
        # too, but links found inside THOSE aren't followed further.
        extra = set()
        for relpath in selected:
            if relpath.lower().endswith(".md"):
                abs_path = os.path.join(root, relpath)
                extra.update(link_rel for link_rel, _, _, _ in linked_files(root_name, abs_path))
        selected |= extra

    buf = io.BytesIO()
    with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as zf:
        for relpath in sorted(selected):
            abs_path = os.path.join(root, relpath)
            rel_to_target = os.path.relpath(abs_path, target)
            # A depth-1 linked file can live outside the folder being
            # zipped (e.g. a sibling directory) - keep those out of the
            # main tree instead of writing a "../"-escaping zip entry.
            arcname = ("_referenced/" + os.path.relpath(abs_path, root)
                       if rel_to_target.startswith("..") else rel_to_target)
            zf.write(abs_path, arcname)
    return buf.getvalue()


def render_export(root_name, rel):
    target = safe_path(root_name, rel)
    if target and os.path.isdir(target):
        return render_export_dir(root_name, rel, target)
    return render_export_file(root_name, rel, target)


def render_export_dir(root_name, rel, target):
    rel = rel.rstrip("/")
    name = rel.split("/")[-1] if rel else root_name
    quoted = urllib.parse.quote(rel)

    # The file list (and each file's size) loads incrementally via JS
    # after the page renders, rather than being computed here - some of
    # these folders hold many GB-sized data files, and scanning them all
    # synchronously before the page can even load is what used to freeze
    # the whole (single-threaded) server for every other open tab too.
    parent = os.path.dirname(rel)
    menu = (f'<div class="menu-bar">'
            f'<a class="copy" href="/browse/{root_name}/{urllib.parse.quote(parent)}">&larr; back</a>'
            f'<span class="menu-right">'
            f'<span class="menu-label">include:</span>'
            f'<button class="copy" onclick="setAllChecked(true)">all</button>'
            f'<button class="copy" onclick="setAllChecked(false)">none</button>'
            f'</span></div>')
    body = f"""
<h2 class="page-title"><a href="/" style="text-decoration:none">&#x1F4C1;</a> {html.escape(name)}/</h2>
{menu}
<p id="export-progress" class="file-stats">loading file list...</p>
<form id="export-form" data-base-lines="0" data-base-chars="0" data-base-bytes="0" data-size-only="1">
<table id="export-table"><tr><th></th><th>name</th><th>size</th></tr></table>
</form>
<p id="export-total" class="file-stats"></p>
<p class="export-actions">
<button class="copy" onclick="exportDownload('/zip/{root_name}/{quoted}','export-form','{html.escape(name)}.zip')">⬇ download zip</button>
<button class="copy" onclick="exportDownload('/zip/{root_name}/{quoted}','export-form','{html.escape(name)}.zip','&expand=1')">⬇ download zip (link depth=1)</button>
</p>
<script>loadExportDir('{root_name}','{quoted}');</script>
"""
    return render_page(f"&#x1F4C1; explorer: export {name}/", "", body)


def render_export_file(root_name, rel, target):
    if not target or not os.path.isfile(target):
        return None
    name = os.path.basename(target)
    quoted = urllib.parse.quote(rel)
    base_lines = count_lines(target)
    base_chars = count_chars(target)
    base_bytes = file_size(target)
    linked = linked_files(root_name, target) if name.lower().endswith(".md") else []

    rows = "".join(
        f'<tr><td><input type="checkbox" value="{html.escape(l)}" data-lines="{lines or 0}" data-chars="{chars or 0}" '
        f'data-bytes="{size}" checked onchange="updateExportTotal()"></td>'
        f'<td>{html.escape(l)}</td><td>{fmt_count(lines)}</td><td>{fmt_count(chars)}</td><td>{human_size(size)}</td></tr>'
        for l, lines, chars, size in linked
    )
    form_attrs = f'data-base-lines="{base_lines or 0}" data-base-chars="{base_chars or 0}" data-base-bytes="{base_bytes}"'
    table = (f'<form id="export-form" {form_attrs}>'
             f'<table><tr><th></th><th>name</th><th>lines</th><th>chars</th><th>size</th></tr>{rows}</table></form>'
             if linked else
             f'<p>(no quoted files)</p><form id="export-form" {form_attrs}></form>')

    menu = (f'<div class="menu-bar">'
            f'<a class="copy" href="/view/{root_name}/{quoted}">&larr; back</a>'
            f'<span class="menu-right">'
            f'<span class="menu-label">include:</span>'
            f'<button class="copy" onclick="setAllChecked(true)">all</button>'
            f'<button class="copy" onclick="setAllChecked(false)">none</button>'
            f'</span></div>')
    body = f"""
<h2 class="page-title"><a href="/" style="text-decoration:none">&#x1F4C1;</a> {html.escape(name)}</h2>
{menu}
<p class="file-stats">this file: {fmt_count(base_lines)} lines, {fmt_count(base_chars)} chars, {human_size(base_bytes)}</p>
{table}
<p id="export-total" class="file-stats"></p>
<script>updateExportTotal();</script>
<p class="export-actions">
<button class="copy" onclick="exportCopy('/raw/{root_name}/{quoted}','export-form',this)">\U0001F4CB copy</button>
<button class="copy" onclick="exportDownload('/raw/{root_name}/{quoted}','export-form','{html.escape(name)}')">⬇ download md</button>
</p>
"""
    return render_page(f"&#x1F4C1; explorer: export {name}", "", body)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        split = urllib.parse.urlsplit(self.path)
        path = urllib.parse.unquote(split.path)
        # keep_blank_values=True: an explicit "?include=" (nothing checked)
        # must stay distinguishable from no "include" param at all (plain
        # /raw/ with no filtering) - parse_qs drops blank values otherwise,
        # which silently turned "include nothing" into "include everything".
        query = urllib.parse.parse_qs(split.query, keep_blank_values=True)
        if path.startswith("/raw/"):
            root_name, rel = split_root(path[len("/raw/"):])
            include = query.get("include", [None])[0]
            include_set = set(include.split(",")) if include else (set() if include == "" else None)
            text = render_raw(root_name, rel, include=include_set)
            if text is None:
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"not found")
                return
            encoded = text.encode()
            action = "copy" if query.get("action", [""])[0] == "copy" else "export"
            log_audit(action, root_name, rel)
            self.send_response(200)
            self.send_header("Content-Type", "text/markdown; charset=utf-8")
            self.send_header("Content-Length", str(len(encoded)))
            self.end_headers()
            self.wfile.write(encoded)
            return
        elif path.startswith("/file/"):
            root_name, rel = split_root(path[len("/file/"):])
            target = safe_path(root_name, rel)
            if not target or not os.path.isfile(target):
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"not found")
                return
            ctype = mimetypes.guess_type(target)[0] or "application/octet-stream"
            with open(target, "rb") as f:
                data = f.read()
            self.send_response(200)
            self.send_header("Content-Type", ctype)
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        elif path.startswith("/export-list/"):
            root_name, rel = split_root(path[len("/export-list/"):])
            target = safe_path(root_name, rel)
            root = load_roots().get(root_name)
            paths = walk_relpaths(target, root) if target and os.path.isdir(target) else []
            data = json.dumps(paths).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        elif path.startswith("/export-meta/"):
            root_name = path[len("/export-meta/"):]
            metas = []
            for relpath in query.get("files", [""])[0].split(","):
                if not relpath:
                    continue
                full = safe_path(root_name, relpath)
                if full and os.path.isfile(full):
                    metas.append({"path": relpath, "size": file_size(full)})
            data = json.dumps(metas).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        elif path.startswith("/zip/"):
            root_name, rel = split_root(path[len("/zip/"):])
            include = query.get("include", [None])[0]
            include_set = set(include.split(",")) if include else (set() if include == "" else None)
            expand_links = query.get("expand", ["0"])[0] == "1"
            data = build_zip(root_name, rel, include=include_set, expand_links=expand_links)
            if data is None:
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"not found")
                return
            name = rel.rstrip("/").split("/")[-1] if rel.rstrip("/") else root_name
            log_audit("export", root_name, rel)
            self.send_response(200)
            self.send_header("Content-Type", "application/zip")
            self.send_header("Content-Length", str(len(data)))
            self.send_header("Content-Disposition", f'attachment; filename="{name}.zip"')
            self.end_headers()
            self.wfile.write(data)
            return
        elif path.startswith("/view/"):
            root_name, rel = split_root(path[len("/view/"):])
            # Links in the md content can point at a directory (not a
            # specific file) - /view/ only knows how to render files, so
            # send those over to /browse/ instead of 404ing.
            target = safe_path(root_name, rel)
            if target and os.path.isdir(target):
                self.send_response(302)
                self.send_header("Location", f"/browse/{root_name}/" + urllib.parse.quote(rel.rstrip("/")))
                self.end_headers()
                return
            body = render_view(root_name, rel)
        elif path.startswith("/export/"):
            root_name, rel = split_root(path[len("/export/"):])
            body = render_export(root_name, rel)
        elif path.startswith("/browse/"):
            root_name, rel = split_root(path[len("/browse/"):])
            body = render_listing(root_name, rel)
        elif path == "/roots/suggest":
            partial = query.get("q", [""])[0]
            data = json.dumps(suggest_paths(partial)).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        elif path.startswith("/roots/remove/"):
            name = urllib.parse.unquote_plus(path[len("/roots/remove/"):])
            roots = load_roots()
            roots.pop(name, None)
            save_roots(roots)
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
            return
        elif path == "/" or path == "":
            body = render_roots()
        elif path == "/audit":
            body = render_audit()
        else:
            body = None

        if body is None:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b"not found")
            return

        encoded = body.encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(encoded)))
        self.end_headers()
        self.wfile.write(encoded)

    def do_POST(self):
        if self.path.startswith("/upload/"):
            root_name, rel = split_root(urllib.parse.unquote(self.path[len("/upload/"):]))
            target_dir = safe_path(root_name, rel)
            length = int(self.headers.get("Content-Length", 0))
            if length > MAX_UPLOAD_BYTES:
                self.send_response(413)
                self.end_headers()
                self.wfile.write(b"file too large (max 1GB)")
                return
            body = self.rfile.read(length)
            m = re.search(r'boundary=([^;]+)', self.headers.get("Content-Type", ""))
            if target_dir and os.path.isdir(target_dir) and m:
                result = parse_multipart_file(body, m.group(1).strip('"'))
                if result and result[0]:
                    filename, data = result
                    with open(os.path.join(target_dir, filename), "wb") as f:
                        f.write(data)
                    log_audit("upload", root_name, f"{rel}/{filename}" if rel else filename)
            self.send_response(302)
            self.send_header("Location", f"/browse/{root_name}/" + urllib.parse.quote(rel.rstrip("/")))
            self.end_headers()
            return
        if self.path.startswith("/delete/"):
            root_name, rel = split_root(urllib.parse.unquote(self.path[len("/delete/"):]))
            delete_file(root_name, rel)
            parent = os.path.dirname(rel.rstrip("/"))
            self.send_response(302)
            self.send_header("Location", f"/browse/{root_name}/" + urllib.parse.quote(parent))
            self.end_headers()
            return
        if self.path == "/roots/add":
            length = int(self.headers.get("Content-Length", 0))
            data = self.rfile.read(length).decode()
            form = urllib.parse.parse_qs(data)
            path = form.get("path", [""])[0].strip()
            if path:
                add_root(path)
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
            return
        self.send_response(404)
        self.end_headers()

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
