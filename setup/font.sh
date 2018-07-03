#!/bin/sh

# clone fonts and put it on .fonts
# NOTE: need to install .ttf manually
git clone https://github.com/macchaberrycream/RictyDiminished-Nerd-Fonts.git ~/.fonts
fc-cache -f -v

# Check current installed fonts
# fc-list | grep Ricty | Regular
# fotmat [font-file-path: font-name:style]

# Replace gnone terminal default font with ricty
# NOTE: need to install gconf-editor before exec below
# format [font-name size]
# gconftool-2 --get /apps/gnome-terminal/profiles/Default/font # to confirm
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Ricty Regular 12"
sudo shutdown -r now # need to restart to use ricty on gnome terminal

