#!/bin/bash

sudo apt install -y fontconfig

# IPA Font for matplotlib
sudo apt install -y fonts-ipafont

# Hack Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip -d Hack
sudo mkdir -p /usr/local/share/fonts/hack
sudo mv Hack/*.ttf /usr/local/share/fonts/hack/

fc-cache -fv
fc-list | grep "Hack"
fc-list | grep "IPA"

rm Hack.zip
rm -rf Hack
