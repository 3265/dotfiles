#!/usr/bin/env python3
import os
import re
import subprocess
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


def render(services, ip):
    rows = []
    for port, addr, proc, cwd in services:
        link = f'<a href="http://{ip}:{port}/">{port}</a>' if addr in ("0.0.0.0", "*") else str(port)
        rows.append(f"<tr><td>{link}</td><td>{addr}</td><td>{proc}</td><td>{cwd}</td></tr>")
    return f"""<!doctype html>
<html><head><meta charset="utf-8"><title>services</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>body{{font-family:monospace;background:#111;color:#eee;font-size:16px;margin:0;padding:8px}}
table{{border-collapse:collapse;width:100%}}
td,th{{padding:8px 10px;border-bottom:1px solid #333;text-align:left;word-break:break-all}}
th{{white-space:nowrap}}
a{{color:#6cf}}</style></head>
<body><h1>listening services</h1><table>
<tr><th>port</th><th>addr</th><th>process</th><th>cwd</th></tr>
{''.join(rows)}
</table></body></html>"""


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = render(listening_services(), host_ip()).encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
