#!/bin/bash

dpkg-query -W -f='${Status}' antigravity 2>/dev/null | grep -q "install ok installed" && { echo "google-antigravity: already installed, skipping"; exit 0; }

# Google Antigravity - official apt repo (pkg.dev)
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/antigravity-repo-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" \
  | sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null

sudo apt update
sudo apt install -y antigravity
