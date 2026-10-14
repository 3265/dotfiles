#!/usr/bin/env python3
import subprocess
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = 6001

# (name, port, description)
SERVICES = [
    ("dashboard", 6002, "listening services, system stats, disk usage"),
    ("explorer", 6003, "browse/view/copy markdown docs"),
]

PAGE = """<!doctype html>
<html><head><meta charset="utf-8"><title>&#x1F3E0; index</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>body{{font-family:monospace;background:#111;color:#eee;font-size:16px;margin:0;padding:8px}}
table{{border-collapse:collapse;width:100%}}
td,th{{padding:8px 10px;border-bottom:1px solid #333;text-align:left;word-break:break-all}}
a{{color:#6cf}}</style></head>
<body><h1>&#x1F3E0; services</h1><table>
<tr><th>name</th><th>port</th><th>description</th></tr>
{rows}
</table></body></html>"""


def host_ip():
    out = subprocess.run(["hostname", "-I"], capture_output=True, text=True).stdout
    return out.split()[0] if out.split() else "127.0.0.1"


def render():
    ip = host_ip()
    rows = "".join(
        f'<tr><td><a href="http://{ip}:{port}/" target="_blank" rel="noopener">{name}</a></td>'
        f'<td>{port}</td><td>{desc}</td></tr>'
        for name, port, desc in SERVICES
    )
    return PAGE.format(rows=rows)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = render().encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
