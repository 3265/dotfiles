#!/bin/bash

dpkg-query -W -f='${Status}' obsidian 2>/dev/null | grep -q "install ok installed" && { echo "obsidian: already installed, skipping"; exit 0; }

# Obsidian - GitHub releases (no official apt repo)
LATEST=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
  | grep -Po '"tag_name": "v\K[^"]*')

DEB="obsidian_${LATEST}_amd64.deb"
wget -O "/tmp/${DEB}" "https://github.com/obsidianmd/obsidian-releases/releases/download/v${LATEST}/${DEB}"
sudo apt install -y "/tmp/${DEB}"
rm "/tmp/${DEB}"
