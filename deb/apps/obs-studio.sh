#!/bin/bash

dpkg-query -W -f='${Status}' obs-studio 2>/dev/null | grep -q "install ok installed" && { echo "obs-studio: already installed, skipping"; exit 0; }

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y obs-studio
