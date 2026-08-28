#!/usr/bin/env python3
import os
import re
import subprocess
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

# 6000 is X11's traditional port and is on Chrome/Firefox's blocked-port list
# (ERR_UNSAFE_PORT), so this can't just be the round number it "should" be.
PORT = 6001


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
        proc, cwd = (m.group(1), process_cwd(m.group(2))) if m else ("-", "-")
        services.append((int(port), addr, proc, cwd))
    return sorted(services)


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
nav{{margin-bottom:12px}}</style></head>
<body><nav>{nav}</nav><h1>{title}</h1>{body}</body></html>"""


def render_services(services, ip):
    rows = []
    for port, addr, proc, cwd in services:
        link = f'<a href="http://{ip}:{port}/" target="_blank" rel="noopener">{port}</a>' if addr in ("0.0.0.0", "*") else str(port)
        rows.append(f"<tr><td>{link}</td><td>{addr}</td><td>{proc}</td><td>{cwd}</td></tr>")
    body = f"""<table>
<tr><th>port</th><th>addr</th><th>process</th><th>cwd</th></tr>
{''.join(rows)}
</table>"""
    nav = '<a href="/stats" target="_blank" rel="noopener">stats &rarr;</a>'
    return PAGE.format(title="listening services", extra_head="", nav=nav, body=body)


def render_stats():
    cpu = cpu_percent()
    used_gb, total_gb, mem_pct = mem_stats()
    gpu = gpu_stats()

    def bar_row(label, pct, detail):
        return f'<h2>{label}: {pct}%</h2><div class="bar"><div style="width:{pct}%"></div></div><p>{detail}</p>'

    rows = bar_row("CPU", cpu, "")
    rows += bar_row("RAM", mem_pct, f"{used_gb:.1f} / {total_gb:.1f} GB")
    if gpu:
        util, vram_used, vram_total, temp = gpu
        vram_pct = round(100 * vram_used / vram_total, 1) if vram_total else 0.0
        rows += bar_row("GPU", util, f"{temp:.0f}°C")
        rows += bar_row("VRAM", vram_pct, f"{vram_used:.1f} / {vram_total:.1f} GB")
    else:
        rows += "<p>GPU: not available</p>"

    nav = '<a href="/" target="_blank" rel="noopener">&larr; services</a>'
    extra_head = '<meta http-equiv="refresh" content="3">'
    return PAGE.format(title="system stats", extra_head=extra_head, nav=nav, body=rows)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/stats"):
            body = render_stats().encode()
        else:
            body = render_services(listening_services(), host_ip()).encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
