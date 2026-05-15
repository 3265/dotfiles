#!/bin/bash

dpkg-query -W -f='${Status}' vivaldi-stable 2>/dev/null | grep -q "install ok installed" && { echo "vivaldi: already installed, skipping"; exit 0; }

# Vivaldi - official deb repo
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub \
  | gpg --dearmor \
  | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg

echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/vivaldi.list

sudo apt update
sudo apt install -y vivaldi-stable
