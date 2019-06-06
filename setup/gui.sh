#!/bin/bash

# terminal
# sudo pacman -S --noconfirm termite
sudo pacman -S --noconfirm terminator

# Browser
# FF
#   Disable opening menu by alt
#   about:config > ui.key.menuAccessKey = 0
#   about:config > ui.key.menuAccessKeyFocuses = false
#   theme
#   https://addons.mozilla.org/ja/firefox/addon/zen-fox/
# for chrome, need to apply Solarized Dark, Solarized dark, Rename tab title, Vimium, Google Translate
sudo pacman -S --noconfirm chromium firefox opera
yay -S --noconfirm google-chrome

# Gnome Tweaks
sudo pacman -S --noconfirm gnome-tweaks

# Clipboard manager
sudo pacman -S --noconfirm parcellite

# Editor
yay -S --noconfirm visual-studio-code-bin
# yay -S --noconfirm unityhub
# yay -S --noconfirm unity-editor-beta
# sudo pacman -S --noconfirm ffmpeg
# yay -S --noconfirm oni

# Tools
sudo pacman -S --noconfirm gparted xpad
yay -S --noconfirm postman ngrok

# Business
yay -S --noconfirm skypeforlinux-stable-bin slack-desktop zoom
yay -S --noconfirm discord

# Tools
# Way to solve permission err of wireshark
# see https://ubuntuforums.org/showthread.php?t=2039978
sudo pacman -S --noconfirm wireshark-common

# File manager
# sudo pacman -S --noconfirm pcmanfm
# sudo pacman -S --noconfirm nautilus
# yay -S gtk-theme-solarc-git --noconfirm

# Printer
# sudo pacman -S --noconfirm cups

# Paper management
# yay -S mendeleydesktop

