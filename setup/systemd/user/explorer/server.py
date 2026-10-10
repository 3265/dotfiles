#!/usr/bin/env python3
import datetime
import html
import json
import os
import re
import subprocess
import urllib.parse
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = 6003

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
function collectIncluded(formId){
  var boxes=document.getElementById(formId).querySelectorAll('input[type=checkbox]:checked');
  return Array.prototype.map.call(boxes,function(c){return encodeURIComponent(c.value);}).join(',');
}
function exportCopy(url,formId,btn){
  fetch(url+'?include='+collectIncluded(formId)).then(function(r){return r.text();}).then(function(t){
    copyToClipboard(t);
    var orig=btn.textContent;
    btn.textContent='copied!';
    setTimeout(function(){btn.textContent=orig;},1200);
  });
}
function exportDownload(url,formId,filename){
  var a=document.createElement('a');
  a.href=url+'?include='+collectIncluded(formId);
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
"""

PAGE = """<!doctype html>
<html><head><meta charset="utf-8"><title>{title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>body{{font-family:monospace;background:#111;color:#eee;font-size:16px;margin:0;padding:8px;overflow-wrap:anywhere}}
table{{border-collapse:collapse;width:100%}}
td,th{{padding:8px 10px;border-bottom:1px solid #333;text-align:left;word-break:break-all}}
a{{color:#6cf}}
.mtime{{cursor:pointer;border-bottom:1px dotted #666;white-space:nowrap}}
.mtime-popup{{position:fixed;background:#222;border:1px solid #555;border-radius:4px;padding:4px 8px;font-size:13px;z-index:100;white-space:nowrap}}
input[type=text]{{background:#1a1a1a;color:#eee;border:1px solid #555;border-radius:4px;padding:6px 8px;font-family:monospace;box-sizing:border-box}}
.add-root{{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:12px}}
.add-root input[type=text]{{flex:1;min-width:200px}}
button.copy,a.copy,button.submit{{background:#333;color:#eee;border:1px solid #555;border-radius:4px;padding:4px 10px;font-family:monospace;cursor:pointer;text-decoration:none;display:inline-block}}
.export-actions button.copy{{padding:4px 8px;font-size:13px;height:30px;display:inline-flex;align-items:center}}
.doc{{font-family:sans-serif;line-height:1.6;max-width:900px}}
.doc pre{{background:#1a1a1a;padding:8px;overflow-x:auto}}
.doc code{{background:#1a1a1a;padding:2px 4px}}
.doc pre code{{background:transparent;padding:0}}
nav{{margin-bottom:12px;display:flex;justify-content:space-between;align-items:center;gap:8px}}
#TOC{{background:#1a1a1a;border:1px solid #333;border-radius:4px;padding:12px 20px;margin-bottom:1.5em}}
#TOC ul{{margin:0}}
{highlight_css}</style>
<script>{copy_js}</script></head>
<body><nav>{nav}</nav>{body}</body></html>"""


def render_page(title, nav, body):
    return PAGE.format(title=title, nav=nav, body=body, highlight_css=HIGHLIGHT_CSS, copy_js=COPY_JS)


def load_roots():
    try:
        with open(ROOTS_FILE, encoding="utf-8") as f:
            return json.load(f)
    except (OSError, json.JSONDecodeError):
        return {}


def save_roots(roots):
    os.makedirs(CONFIG_DIR, exist_ok=True)
    with open(ROOTS_FILE, "w", encoding="utf-8") as f:
        json.dump(roots, f, ensure_ascii=False, indent=2)


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


def linked_files(root_name, target):
    """(root-relative path, line count) for the local text files target
    plain-links to (dedup, one level - same set bundle() would expand with
    include=None)."""
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
                seen.append((rel, count_lines(abs_path)))
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


def count_lines(path):
    try:
        with open(path, "rb") as f:
            return sum(1 for _ in f)
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


def render_roots():
    roots = load_roots()
    rows = []
    for name, path in sorted(roots.items()):
        rows.append(
            f'<tr><td><a href="/browse/{urllib.parse.quote(name)}/">{html.escape(name)}</a></td>'
            f'<td>{html.escape(path)}</td>'
            f'<td><a href="/roots/remove/{urllib.parse.quote(name)}">remove</a></td></tr>'
        )
    table = (f"<table><tr><th>name</th><th>path</th><th></th></tr>{''.join(rows)}</table>"
             if rows else "<p>no roots registered yet</p>")
    form = """
<form method="post" action="/roots/add" class="add-root">
<input type="text" name="path" placeholder="/absolute/path/to/project">
<button class="submit" type="submit">add root</button>
</form>
"""
    return render_page("pandoc-md-explorer", "", f"{form}{table}")


def render_listing(root_name, rel):
    target = safe_path(root_name, rel)
    if not target or not os.path.isdir(target):
        return None
    try:
        entries = sorted(os.listdir(target))
    except OSError:
        entries = []

    rows = []
    if rel:
        parent = os.path.dirname(rel.rstrip("/"))
        rows.append(f'<tr><td colspan="5"><a href="/browse/{root_name}/{urllib.parse.quote(parent)}">.. (up)</a></td></tr>')
    else:
        rows.append('<tr><td colspan="5"><a href="/">.. (all roots)</a></td></tr>')

    file_count = 0
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
            sub_count = count_files(full)
            rows.append(f'<tr><td><a href="/browse/{root_name}/{quoted}">{html.escape(name)}/</a></td><td>dir</td>'
                        f'<td>{sub_count}</td>{mtime_td}<td></td></tr>')
        elif name.lower().endswith(".md"):
            file_count += 1
            lines = count_lines(full)
            actions = f'<a class="copy" href="/export/{root_name}/{quoted}">&#x1F4E4;</a>'
            rows.append(f'<tr><td><a href="/view/{root_name}/{quoted}">{html.escape(name)}</a></td><td>md</td>'
                        f'<td>{lines}</td>{mtime_td}<td>{actions}</td></tr>')
        elif not is_probably_binary(full):
            file_count += 1
            lines = count_lines(full)
            actions = f'<a class="copy" href="/export/{root_name}/{quoted}">&#x1F4E4;</a>'
            rows.append(f'<tr><td><a href="/view/{root_name}/{quoted}">{html.escape(name)}</a></td><td>text</td>'
                        f'<td>{lines}</td>{mtime_td}<td>{actions}</td></tr>')
        else:
            file_count += 1
            rows.append(f'<tr><td>{html.escape(name)}</td><td>bin</td><td></td>{mtime_td}<td></td></tr>')

    summary = f"<p>{file_count} files here</p>"
    body = (f"{summary}<table><tr>"
            f'<th>name</th><th>type</th><th>size</th><th>mod</th><th></th>'
            f"</tr>{''.join(rows)}</table>")
    return render_page(f"explorer: {root_name}/{rel}", f"{root_name}/{html.escape(rel)}", body)


def render_view(root_name, rel):
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target):
        return None

    ext = os.path.splitext(target)[1].lower()
    title_meta = f"--metadata=title={os.path.basename(target)}"

    if ext == ".md":
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
            [PANDOC, "-f", "markdown", "-t", "html", "-s", "--highlight-style", "breezedark",
             "--toc", "--toc-depth=3", title_meta, target],
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
            return render_page(os.path.basename(target), "", f"<pre>{html.escape(str(e))}</pre>")
        lang = LANG_BY_EXT.get(ext, "")
        fence = "````"
        wrapped = f"{fence}{lang}\n{raw}\n{fence}\n"
        out = subprocess.run(
            [PANDOC, "-f", "markdown", "-t", "html", "-s", "--highlight-style", "breezedark", title_meta],
            input=wrapped, capture_output=True, text=True,
        )

    if out.returncode != 0:
        content = f"<pre>{html.escape(out.stderr)}</pre>"
    else:
        m = re.search(r"<body>\n?(.*)</body>", out.stdout, re.DOTALL)
        content = m.group(1) if m else out.stdout

    parent = os.path.dirname(rel)
    quoted = urllib.parse.quote(rel)
    name = os.path.basename(target)
    nav = (f'<a href="/browse/{root_name}/{urllib.parse.quote(parent)}">&larr; back to {root_name}/{html.escape(parent)}</a> '
           f'<a class="copy" href="/export/{root_name}/{quoted}">&#x1F4E4;</a>')
    return render_page(os.path.basename(target), nav, f'<div class="doc">{content}</div>')


def render_raw(root_name, rel, include=None):
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target):
        return None
    return bundle(root_name, target, include=include)


def render_export(root_name, rel):
    target = safe_path(root_name, rel)
    if not target or not os.path.isfile(target):
        return None
    name = os.path.basename(target)
    quoted = urllib.parse.quote(rel)
    linked = linked_files(root_name, target) if name.lower().endswith(".md") else []

    rows = "".join(
        f'<tr><td><input type="checkbox" value="{html.escape(l)}" checked></td>'
        f'<td>{html.escape(l)}</td><td>{lines}</td></tr>'
        for l, lines in linked
    )
    table = (f'<form id="export-form"><table><tr><th></th><th>name</th><th>lines</th></tr>{rows}</table></form>'
             if linked else '<p>(no quoted files)</p><form id="export-form"></form>')

    body = f"""
<h2>{html.escape(name)}</h2>
<p>quoted files to include:</p>
{table}
<p class="export-actions">
<button class="copy" onclick="exportCopy('/raw/{root_name}/{quoted}','export-form',this)">\U0001F4CB copy</button>
<button class="copy" onclick="exportDownload('/raw/{root_name}/{quoted}','export-form','{html.escape(name)}')">⬇ download</button>
</p>
"""
    nav = f'<a href="/view/{root_name}/{quoted}">&larr; back to {html.escape(name)}</a>'
    return render_page(f"export: {name}", nav, body)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        split = urllib.parse.urlsplit(self.path)
        path = urllib.parse.unquote(split.path)
        query = urllib.parse.parse_qs(split.query)
        if path.startswith("/raw/"):
            root_name, rel = split_root(path[len("/raw/"):])
            include = query.get("include", [None])[0]
            include_set = set(include.split(",")) if include else None
            text = render_raw(root_name, rel, include=include_set)
            if text is None:
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"not found")
                return
            encoded = text.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/markdown; charset=utf-8")
            self.send_header("Content-Length", str(len(encoded)))
            self.end_headers()
            self.wfile.write(encoded)
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
