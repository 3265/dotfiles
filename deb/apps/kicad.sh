#!/bin/bash

dpkg-query -W -f='${Status}' kicad 2>/dev/null | grep -q "install ok installed" && { echo "kicad: already installed, skipping"; exit 0; }

sudo add-apt-repository -y ppa:kicad/kicad-9-releases
sudo apt update
sudo apt install -y kicad
