#!/bin/bash

echo "== apt =="
sudo apt update
sudo apt full-upgrade
sudo apt autoremove
sudo apt autoclean

# No auto-update timer on this system, unlike snap below - needs a manual run.
echo "== flatpak =="
command -v flatpak >/dev/null && flatpak update
command -v flatpak >/dev/null && flatpak uninstall --unused

# snapd already refreshes itself several times a day in the background; this
# is just here so nothing gets silently skipped when eyeballing this script.
echo "== snap =="
command -v snap >/dev/null && sudo snap refresh

echo "== firmware =="
command -v fwupdmgr >/dev/null && sudo fwupdmgr refresh && sudo fwupdmgr update

echo "== journal =="
sudo journalctl --vacuum-time=4weeks
