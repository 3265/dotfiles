#!/usr/bin/env python3
import html
import os
import pty
import re
import signal
import subprocess
import time
import urllib.parse
from http.server import BaseHTTPRequestHandler, HTTPServer

# 6000 is X11's traditional port and is on Chrome/Firefox's blocked-port list
# (ERR_UNSAFE_PORT), so this can't just be the round number it "should" be.
PORT = 6002

ZELLIJ = "/home/mike/.cargo/bin/zellij"

# Ports/process names the "services" page's delete button refuses to touch,
# even if the request claims a matching pid - ssh (remote access), this
# dashboard's own trio of services, and dropbox (breaks sync if killed).
PROTECTED_PORTS = {22, 6001, 6002, 6003}
PROTECTED_PROCS = {"dropbox"}


def host_ip():
    out = subprocess.run(["hostname", "-I"], capture_output=True, text=True).stdout
    return out.split()[0] if out.split() else "127.0.0.1"


def process_cwd(pid):
    try:
        return os.readlink(f"/proc/{pid}/cwd")
    except OSError:
        return "-"


def listening_services():
    out = subprocess.run(["ss", "-tlnp"], capture_output=True, text=True).stdout
    seen = set()
    services = []
    for line in out.splitlines()[1:]:
        parts = line.split()
        if len(parts) < 4:
            continue
        addr, _, port = parts[3].rpartition(":")
        if port in seen:
            continue
        seen.add(port)
        m = re.search(r'"([^"]+)",pid=(\d+)', line)
        proc, pid = (m.group(1), m.group(2)) if m else ("-", None)
        cwd = process_cwd(pid) if pid else "-"
        services.append((int(port), addr, proc, cwd, pid))
    return sorted(services)


def kill_service(port, pid):
    """Only kills a listening-port process the caller named by BOTH port
    and pid, re-checked here against what's actually listening right now -
    a request can't just supply an arbitrary pid and have it killed."""
    port = int(port)
    if port in PROTECTED_PORTS:
        return
    for p, addr, proc, cwd, listed_pid in listening_services():
        if p == port and listed_pid == str(pid) and proc not in PROTECTED_PROCS:
            try:
                os.kill(int(pid), signal.SIGTERM)
            except OSError:
                pass
            return


def cpu_percent():
    def sample():
        with open("/proc/stat") as f:
            vals = list(map(int, f.readline().split()[1:]))
        return vals[3] + vals[4], sum(vals)  # idle+iowait, total

    idle1, total1 = sample()
    time.sleep(0.2)
    idle2, total2 = sample()
    total_delta = total2 - total1
    return round(100 * (1 - (idle2 - idle1) / total_delta), 1) if total_delta else 0.0


def mem_stats():
    info = {}
    with open("/proc/meminfo") as f:
        for line in f:
            k, v = line.split(":", 1)
            info[k] = int(v.split()[0])  # kB
    total, avail = info["MemTotal"], info["MemAvailable"]
    used = total - avail
    return used / 1048576, total / 1048576, round(100 * used / total, 1)


def swap_stats():
    info = {}
    with open("/proc/meminfo") as f:
        for line in f:
            k, v = line.split(":", 1)
            info[k] = int(v.split()[0])  # kB
    total, free = info["SwapTotal"], info["SwapFree"]
    used = total - free
    pct = round(100 * used / total, 1) if total else 0.0
    return used / 1048576, total / 1048576, pct


def gpu_stats():
    out = subprocess.run(
        ["nvidia-smi", "--query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu",
         "--format=csv,noheader,nounits"],
        capture_output=True, text=True,
    )
    if out.returncode != 0 or not out.stdout.strip():
        return None
    util, used, total, temp = (float(x) for x in out.stdout.strip().split(","))
    return util, used / 1024, total / 1024, temp


def ttyd_ports():
    # zellij session names can contain spaces, so the name is taken as
    # everything after "--create " rather than a single \S+ token.
    out = subprocess.run(["ps", "-eo", "pid=,args="], capture_output=True, text=True).stdout
    ports = {}
    for line in out.splitlines():
        if "ttyd " not in line or "zellij attach --create " not in line:
            continue
        m = re.search(r"-p\s+(\S+).*zellij attach --create (.+)$", line)
        if m:
            ports[m.group(2)] = m.group(1)
    return ports


def ttyd_sessions():
    # systemd user services don't get the login-shell PATH, so this needs
    # the full path rather than relying on `zellij` being found on PATH.
    out = subprocess.run([ZELLIJ, "list-sessions", "-n"],
                          capture_output=True, text=True).stdout
    ports = ttyd_ports()
    rows = []
    seen = set()
    for line in out.splitlines():
        m = re.match(r"(.+?) \[Created ([^\]]+)\](.*)$", line.strip())
        if not m:
            continue
        name, created, rest = m.groups()
        status = "exited" if "EXITED" in rest else "live"
        rows.append((name, ports.get(name), status, created))
        seen.add(name)
    # ttyd only spawns the actual zellij session once a browser opens its
    # websocket - right after "+ add" the bridge is listening but the
    # session doesn't exist yet, so without this it'd be invisible (no row
    # to click) until something else happened to connect to it first.
    for name, port in ports.items():
        if name not in seen:
            rows.append((name, port, "pending", "-"))
    return rows


def kill_session(name):
    """Best-effort teardown of one ttyd/zellij session - these otherwise
    just pile up: a zellij session left running after its ttyd tab was
    closed, or (seen in the wild) a ttyd process still bridging to a
    session that was already killed some other way, each quietly holding
    onto memory for nothing."""
    subprocess.run([ZELLIJ, "kill-session", name], capture_output=True)
    subprocess.run([ZELLIJ, "delete-session", name], capture_output=True)

    out = subprocess.run(["ps", "-eo", "pid=,ppid=,args="], capture_output=True, text=True).stdout
    rows = [line.split(None, 2) for line in out.splitlines()]
    rows = [r for r in rows if len(r) == 3]
    ttyd_pids = {pid for pid, ppid, args in rows
                 if "ttyd " in args and args.rstrip().endswith(f"zellij attach --create {name}")}
    victims = set(ttyd_pids)
    victims.update(pid for pid, ppid, args in rows if ppid in ttyd_pids)
    for pid in victims:
        try:
            os.kill(int(pid), signal.SIGTERM)
        except OSError:
            pass


TTYD_PORT_RANGE = range(7000, 7100)


def used_ttyd_ports():
    # ttyd_ports() collapses to one port per *name*, so two ttyd processes
    # bridging the same session (seen in the wild - see the dashboard's
    # memory-cleanup discussion) silently drop one of their ports from that
    # map. Picking a "free" port for a new session needs every port that's
    # actually bound, not just one per name.
    out = subprocess.run(["ps", "-eo", "args="], capture_output=True, text=True).stdout
    ports = set()
    for line in out.splitlines():
        if "ttyd " not in line:
            continue
        m = re.search(r"-p\s+(\d+)", line)
        if m:
            ports.add(int(m.group(1)))
    return ports


def add_session(name):
    """Launch a brand-new ttyd+zellij session, mirroring exactly how the
    existing ones were started (see ttyd_ports()'s regex) so it shows up
    the same way in the listing."""
    free_ports = (p for p in TTYD_PORT_RANGE if p not in used_ttyd_ports())
    port = next(free_ports, None)
    if port is None:
        return
    home = os.path.expanduser("~")
    # zellij registers the session (visible to `list-sessions`) as soon as
    # it starts the session's server, before it ever touches the terminal -
    # ttyd only actually runs this same command once a client's websocket
    # finishes its own init handshake, which a plain "+ add" click doesn't
    # do, so without this the new row would sit stuck on "pending" until
    # someone happened to open its tab. This pre-creates it through a real
    # (if throwaway) pty rather than /dev/null, so the pane's shell starts
    # with a proper TERM baked in - that env is set once, at the pane's
    # creation, and doesn't get fixed just because ttyd attaches with a
    # better TERM later; a bare /dev/null here previously left every fresh
    # session's shell complaining "TERM environment variable not set" from
    # the moment it was first opened.
    env = dict(os.environ, TERM="xterm-256color")
    master_fd, slave_fd = pty.openpty()
    try:
        proc = subprocess.Popen([ZELLIJ, "attach", "--create", name], cwd=home, env=env,
                                 stdin=slave_fd, stdout=slave_fd, stderr=slave_fd,
                                 start_new_session=True)
        os.close(slave_fd)
        try:
            proc.wait(timeout=3)
        except subprocess.TimeoutExpired:
            proc.terminate()  # just disconnects this throwaway client - the
                               # session server it already started lives on
    finally:
        os.close(master_fd)
    subprocess.Popen(
        ["/usr/bin/ttyd", "-W", "-i", "0.0.0.0", "-p", str(port), "-t", f"titleFixed={name}",
         "-I", os.path.expanduser("~/.cache/ttyd/index.html"),
         ZELLIJ, "attach", "--create", name],
        start_new_session=True, cwd=home, stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )


def disk_stats():
    out = subprocess.run(["df", "-h"], capture_output=True, text=True).stdout
    disks = []
    for line in out.splitlines()[1:]:
        parts = line.split()
        if len(parts) < 6 or not parts[0].startswith("/dev/"):
            continue
        fs, size, used, avail, pct, mount = parts[:6]
        disks.append((mount, size, used, avail, pct))
    return sorted(disks)


TABS = [("/", "ttyd"), ("/services", "services"), ("/stats", "stats"), ("/disk", "disk")]

PAGE = """<!doctype html>
<html><head><meta charset="utf-8"><title>{title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
{extra_head}
<style>body{{font-family:monospace;background:#111;color:#eee;font-size:16px;margin:0;padding:8px}}
table{{border-collapse:collapse;width:100%}}
td,th{{padding:8px 10px;border-bottom:1px solid #333;text-align:left;word-break:break-all}}
th{{white-space:nowrap}}
a{{color:#6cf}}
.bar{{background:#333;border-radius:4px;overflow:hidden;height:20px;margin:4px 0 16px}}
.bar div{{background:#6cf;height:100%}}
nav{{display:flex;flex-wrap:wrap;border-bottom:2px solid #333;margin:12px 0}}
nav a{{padding:8px 16px;border:none;border-bottom:2px solid transparent;margin-bottom:-2px;color:#888;text-decoration:none}}
nav a.active{{color:#6cf;border-bottom-color:#6cf}}
nav a:hover{{color:#eee}}
.page-actions{{margin:0 0 12px;display:flex;flex-wrap:wrap;justify-content:flex-end;gap:8px}}
.page-actions a{{background:#333;color:#eee;border:1px solid #555;border-radius:4px;padding:6px 12px;
text-decoration:none;cursor:pointer;font-family:monospace}}
.page-actions a:hover{{background:#444}}
button.kill{{background:#511;color:#fbb;border:1px solid #733;border-radius:4px;padding:4px 10px;font-family:monospace;cursor:pointer}}
button.submit{{background:#333;color:#eee;border:1px solid #555;border-radius:4px;padding:4px 10px;font-family:monospace;cursor:pointer}}
input[type=text]{{background:#1a1a1a;color:#eee;border:1px solid #555;border-radius:4px;padding:6px 8px;font-family:monospace;box-sizing:border-box}}
.modal-overlay{{display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:200;align-items:center;justify-content:center}}
.modal-overlay.open{{display:flex}}
.modal-box{{box-sizing:border-box;background:#1a1a1a;border:1px solid #444;border-radius:8px;padding:20px;max-width:90%;width:320px}}
.add-form{{display:flex;flex-direction:column;gap:8px;margin-top:8px}}
.add-form input{{width:100%}}
.add-form-buttons{{display:flex;gap:8px;justify-content:flex-end}}
.row-menu-wrap{{position:relative;display:inline-block}}
.row-menu-btn{{background:none;border:none;color:#888;cursor:pointer;font-size:18px;line-height:1;padding:2px 8px}}
.row-menu-btn:hover{{color:#eee}}
.row-menu{{display:none;position:absolute;right:0;top:100%;z-index:50;min-width:120px;background:#1a1a1a;border:1px solid #444;border-radius:6px;box-shadow:0 4px 12px rgba(0,0,0,.4)}}
.row-menu.open{{display:block}}
.row-menu button.kill{{width:100%;white-space:nowrap;text-align:left;border:none;border-radius:6px;padding:8px 14px}}</style>
<script>
function showAddModal(){{var m=document.getElementById('add-modal');if(m)m.classList.add('open');}}
function hideAddModal(){{var m=document.getElementById('add-modal');if(m)m.classList.remove('open');}}
function toggleRowMenu(btn,e){{
  e.stopPropagation();
  var menu=btn.nextElementSibling;
  var open=menu.classList.contains('open');
  closeAllRowMenus();
  if(!open)menu.classList.add('open');
}}
function closeAllRowMenus(){{
  document.querySelectorAll('.row-menu.open').forEach(function(m){{m.classList.remove('open');}});
}}
document.addEventListener('click',closeAllRowMenus);
</script></head>
<body><h1><a href="/" style="text-decoration:none">&#x1F4CA;</a> {heading}</h1><nav>{nav}</nav>{page_actions}{body}</body></html>"""


def render_nav(active):
    return "".join(
        f'<a href="{href}"{" class=\"active\"" if href == active else ""}>{label}</a>'
        for href, label in TABS
    )


def render_ttyd(ip):
    rows = []
    for name, port, status, created in ttyd_sessions():
        port_cell = f'<a href="http://{ip}:{port}/" target="_blank" rel="noopener">{port}</a>' if port else "-"
        escaped = html.escape(name)
        kill_cell = (f'<div class="row-menu-wrap">'
                     f'<button type="button" class="row-menu-btn" onclick="toggleRowMenu(this,event)" title="more">&#x22EE;</button>'
                     f'<div class="row-menu">'
                     f'<form method="post" action="/kill" style="margin:0" '
                     f'onsubmit="return confirm(\'kill \\\'{escaped}\\\'?\')">'
                     f'<input type="hidden" name="name" value="{escaped}">'
                     f'<button class="kill" type="submit">&#x1F5D1; kill</button></form>'
                     f'</div></div>')
        rows.append(f"<tr><td>{escaped}</td><td>{port_cell}</td><td>{status}</td><td>{created}</td><td>{kill_cell}</td></tr>")
    add_modal = """
<div id="add-modal" class="modal-overlay" onclick="if(event.target===this)hideAddModal()">
<div class="modal-box">
<h3>new session</h3>
<form method="post" action="/add-session" class="add-form">
<input type="text" name="name" placeholder="session name" required autofocus>
<div class="add-form-buttons">
<button type="button" class="submit" onclick="hideAddModal()">cancel</button>
<button class="submit" type="submit">create</button>
</div>
</form>
</div>
</div>"""
    page_actions = '<div class="page-actions"><a onclick="showAddModal()">+ add</a></div>'
    body = f"""<table>
<tr><th>name</th><th>ttyd</th><th>status</th><th>created</th><th></th></tr>
{''.join(rows)}
</table>{add_modal}"""
    return PAGE.format(title="&#x1F4CA; dashboard: ttyd", heading="dashboard: ttyd", extra_head="", nav=render_nav("/"),
                        page_actions=page_actions, body=body)


def render_services(services, ip):
    rows = []
    for port, addr, proc, cwd, pid in services:
        link = f'<a href="http://{ip}:{port}/" target="_blank" rel="noopener">{port}</a>' if addr in ("0.0.0.0", "*") else str(port)
        protected = port in PROTECTED_PORTS or proc in PROTECTED_PROCS
        if pid and not protected:
            kill_cell = (f'<div class="row-menu-wrap">'
                         f'<button type="button" class="row-menu-btn" onclick="toggleRowMenu(this,event)" title="more">&#x22EE;</button>'
                         f'<div class="row-menu">'
                         f'<form method="post" action="/kill-service" style="margin:0" '
                         f'onsubmit="return confirm(\'kill {proc} (port {port})?\')">'
                         f'<input type="hidden" name="port" value="{port}">'
                         f'<input type="hidden" name="pid" value="{pid}">'
                         f'<button class="kill" type="submit">&#x1F5D1; kill</button></form>'
                         f'</div></div>')
        else:
            kill_cell = ""
        rows.append(f"<tr><td>{link}</td><td>{addr}</td><td>{proc}</td><td>{cwd}</td><td>{kill_cell}</td></tr>")
    body = f"""<table>
<tr><th>port</th><th>addr</th><th>process</th><th>cwd</th><th></th></tr>
{''.join(rows)}
</table>"""
    return PAGE.format(title="&#x1F4CA; dashboard: services", heading="dashboard: services", extra_head="", nav=render_nav("/services"),
                        page_actions="", body=body)


def render_stats():
    cpu = cpu_percent()
    used_gb, total_gb, mem_pct = mem_stats()
    gpu = gpu_stats()

    def bar_row(label, pct, detail):
        return f'<h2>{label}: {pct}%</h2><div class="bar"><div style="width:{pct}%"></div></div><p>{detail}</p>'

    swap_used, swap_total, swap_pct = swap_stats()

    rows = bar_row("CPU", cpu, "")
    rows += bar_row("RAM", mem_pct, f"{used_gb:.1f} / {total_gb:.1f} GB")
    if swap_total:
        rows += bar_row("Swap", swap_pct, f"{swap_used:.1f} / {swap_total:.1f} GB")
    else:
        rows += "<p>Swap: not configured</p>"
    if gpu:
        util, vram_used, vram_total, temp = gpu
        vram_pct = round(100 * vram_used / vram_total, 1) if vram_total else 0.0
        rows += bar_row("GPU", util, f"{temp:.0f}°C")
        rows += bar_row("VRAM", vram_pct, f"{vram_used:.1f} / {vram_total:.1f} GB")
    else:
        rows += "<p>GPU: not available</p>"

    extra_head = '<meta http-equiv="refresh" content="3">'
    return PAGE.format(title="&#x1F4CA; dashboard: stats", heading="dashboard: stats", extra_head=extra_head, nav=render_nav("/stats"),
                        page_actions="", body=rows)


def render_disk():
    rows = [f"<tr><td>{mount}</td><td>{used} / {size}</td><td>{avail} free</td><td>{pct}</td></tr>"
            for mount, size, used, avail, pct in disk_stats()]
    body = f"""<table>
<tr><th>mount</th><th>used / size</th><th>avail</th><th>use%</th></tr>
{''.join(rows)}
</table>"""
    return PAGE.format(title="&#x1F4CA; dashboard: disk", heading="dashboard: disk", extra_head="", nav=render_nav("/disk"),
                        page_actions="", body=body)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/services"):
            body = render_services(listening_services(), host_ip()).encode()
        elif self.path.startswith("/stats"):
            body = render_stats().encode()
        elif self.path.startswith("/disk"):
            body = render_disk().encode()
        else:
            body = render_ttyd(host_ip()).encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path in ("/kill", "/add-session"):
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length).decode()
            name = urllib.parse.parse_qs(body).get("name", [""])[0]
            if name:
                (kill_session if self.path == "/kill" else add_session)(name)
            self.send_response(302)
            self.send_header("Location", "/")
            self.end_headers()
            return
        if self.path == "/kill-service":
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length).decode()
            fields = urllib.parse.parse_qs(body)
            port = fields.get("port", [""])[0]
            pid = fields.get("pid", [""])[0]
            if port and pid:
                kill_service(port, pid)
            self.send_response(302)
            self.send_header("Location", "/services")
            self.end_headers()
            return
        self.send_response(404)
        self.end_headers()
        self.wfile.write(b"not found")

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
