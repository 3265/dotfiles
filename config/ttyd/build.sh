#!/bin/bash
# Regenerates ~/.cache/ttyd/index.html by fetching the *stock* index.html that the
# locally installed ttyd binary serves, then injecting touchbar.css/touchbar.js
# (the only files in this directory we actually own) before </head>/</body>.
#
# We deliberately do NOT commit ttyd's generated HTML/JS bundle to this repo -
# it's a build artifact of the ttyd project, not our source. This script
# re-derives it from whatever ttyd is installed, every time `t create` runs.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="$HOME/.cache/ttyd"
OUT_FILE="$OUT_DIR/index.html"
mkdir -p "$OUT_DIR"

port=17000
while ss -ltn 2>/dev/null | grep -q ":$port "; do
    port=$((port + 1))
done

ttyd -p "$port" -i 127.0.0.1 bash >/dev/null 2>&1 &
ttyd_pid=$!
trap 'kill "$ttyd_pid" 2>/dev/null || true' EXIT

ok=0
for _ in $(seq 1 30); do
    if curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:$port/" 2>/dev/null | grep -q 200; then
        ok=1
        break
    fi
    sleep 0.1
done
if [ "$ok" -ne 1 ]; then
    echo "build.sh: ttyd never came up on port $port" >&2
    exit 1
fi

base_html="$(curl -s "http://127.0.0.1:$port/")"
kill "$ttyd_pid" 2>/dev/null || true
trap - EXIT

for anchor in '<head>' '</head>' '</body>' '#terminal-container' '.xterm-helper-textarea'; do
    if [[ "$base_html" != *"$anchor"* ]]; then
        echo "build.sh: installed ttyd's HTML no longer contains '$anchor' - touchbar.js/css assumptions are stale, refusing to patch" >&2
        exit 1
    fi
done

base_html_file="$(mktemp)"
trap 'rm -f "$base_html_file"' EXIT
printf '%s' "$base_html" >"$base_html_file"

python3 - "$base_html_file" "$SRC_DIR/touchbar.css" "$SRC_DIR/touchbar.js" "$OUT_FILE" <<'PYEOF'
import sys

html_path, css_path, js_path, out_path = sys.argv[1:5]
html = open(html_path, encoding="utf-8").read()
css = open(css_path, encoding="utf-8").read()
js = open(js_path, encoding="utf-8").read()

viewport = '<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">'
html = html.replace("<head>", "<head>" + viewport, 1)
html = html.replace("</head>", f"<style>\n{css}</style>\n</head>", 1)
html = html.replace("</body>", f"<script>\n{js}</script>\n</body>", 1)

open(out_path, "w", encoding="utf-8").write(html)
PYEOF

echo "$OUT_FILE"
