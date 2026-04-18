#!/bin/bash

dpkg-query -W -f='${Status}' freecad 2>/dev/null | grep -q "install ok installed" && { echo "freecad: already installed, skipping"; exit 0; }

sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
sudo apt update
sudo apt install -y freecad
