#!/bin/bash

dpkg-query -W -f='${Status}' simplenote 2>/dev/null | grep -q "install ok installed" && { echo "simplenote: already installed, skipping"; exit 0; }

# Simplenote - GitHub releases (no official apt repo)
LATEST=$(curl -s https://api.github.com/repos/Automattic/simplenote-electron/releases/latest \
  | grep -Po '"tag_name": "v\K[^"]*')

DEB="Simplenote-linux-${LATEST}-amd64.deb"
wget -O "/tmp/${DEB}" "https://github.com/Automattic/simplenote-electron/releases/download/v${LATEST}/${DEB}"
sudo apt install -y "/tmp/${DEB}"
rm "/tmp/${DEB}"
