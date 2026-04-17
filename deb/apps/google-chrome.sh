#!/bin/bash

dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -q "install ok installed" && { echo "google-chrome: already installed, skipping"; exit 0; }

# Google Chrome - official deb repo
wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
  | gpg --dearmor \
  | sudo dd of=/usr/share/keyrings/google-chrome.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt update
sudo apt install -y google-chrome-stable
