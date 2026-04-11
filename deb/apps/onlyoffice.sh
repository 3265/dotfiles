#!/bin/bash

dpkg-query -W -f='${Status}' onlyoffice-desktopeditors 2>/dev/null | grep -q "install ok installed" && { echo "onlyoffice: already installed, skipping"; exit 0; }

# OnlyOffice Desktop Editors - official deb repo
gpg --no-default-keyring \
  --keyring gnupg-ring:/tmp/onlyoffice.gpg \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" \
  | sudo tee /etc/apt/sources.list.d/onlyoffice.list

sudo apt update
sudo apt install -y onlyoffice-desktopeditors
