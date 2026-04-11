#!/bin/bash

dpkg-query -W -f='${Status}' filezilla 2>/dev/null | grep -q "install ok installed" && dpkg-query -W -f='${Status}' thunderbird 2>/dev/null | grep -q "install ok installed" && { echo "mail: already installed, skipping"; exit 0; }

# FileZilla
sudo apt install -y filezilla

# Thunderbird - Mozilla official deb repo
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
  | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
  | sudo tee /etc/apt/sources.list.d/mozilla.list

# Prefer Mozilla repo over Ubuntu's snap-redirected package
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt update
sudo apt install -y thunderbird
