#!/bin/bash

dpkg-query -W -f='${Status}' balena-etcher 2>/dev/null | grep -q "install ok installed" && { echo "balena-etcher: already installed, skipping"; exit 0; }

# Balena Etcher - GitHub releases (no official apt repo)
LATEST=$(curl -s https://api.github.com/repos/balena-io/etcher/releases/latest \
  | grep -Po '"tag_name": "v\K[^"]*')

DEB="balena-etcher_${LATEST}_amd64.deb"
wget -O "/tmp/${DEB}" "https://github.com/balena-io/etcher/releases/download/v${LATEST}/${DEB}"
sudo apt install -y "/tmp/${DEB}"
rm "/tmp/${DEB}"
