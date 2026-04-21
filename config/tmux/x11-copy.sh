#!/usr/bin/env bash
set -euo pipefail

# Requirements:
# - SSH config (client): ForwardX11 yes / ForwardX11Trusted yes (or use `ssh -X`)
# - Server: X11Forwarding yes in sshd_config, and xauth installed
# - Remote: xclip or xsel available
# - Local: X11 session (not Wayland) to receive clipboard

copy_to_tmux() {
  tmux load-buffer -
}

if [ -n "${DISPLAY:-}" ]; then
  if command -v xclip >/dev/null 2>&1; then
    tee >(xclip -selection clipboard -in) | copy_to_tmux
    exit 0
  fi
  if command -v xsel >/dev/null 2>&1; then
    tee >(xsel --clipboard --input) | copy_to_tmux
    exit 0
  fi
fi

copy_to_tmux
