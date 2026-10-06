#!/bin/bash
# zellij copy_command: writes the selection to both places at once.
#
# - Local X11 clipboard via xsel, for the physical terminal (Konsole etc.),
#   since OSC52 support through this nested terminal/mux chain is unreliable.
# - An OSC52 escape sequence written straight to /dev/tty, so ttyd/xterm.js
#   in the browser can also pick it up and write it to the *browser's*
#   clipboard (a plain xsel write only reaches this machine's X11 clipboard,
#   not a remote client's). Writing to stdout instead of /dev/tty doesn't
#   work here - zellij intercepts OSC52 on a child process's stdout rather
#   than passing it through to the outer terminal; /dev/tty bypasses that.
#
# zellij's copy_command replaces its default OSC52 emission entirely, so
# without this we'd only get one or the other, not both.

text="$(cat)"
printf '%s' "$text" | xsel --clipboard --input
printf '\033]52;c;%s\a' "$(printf '%s' "$text" | base64 | tr -d '\n')" > /dev/tty
