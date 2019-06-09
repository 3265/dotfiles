#!/bin/bash

# X.org
sudo pacman -S --noconfirm xorg-xmodmap

# terminal
# sudo pacman -S --noconfirm termite
sudo pacman -S --noconfirm terminator

# Launcher
sudo pacman -S --noconfirm xbindkeys
sudo pacman -S --noconfirm rofi

# Gnome Tools
sudo pacman -S --noconfirm gnome-tweaks
yay -S --noconfirm gnome-shell-extension-clipboard-indicator-git # clipboard
yay -S --noconfirm gnome-shell-extension-caffeine-plus-git # caffeine
yay -S --noconfirm gnome-shell-extension-gsconnect # connect to Android
yay -S --noconfirm gnome-shell-extension-system-monitor-git

# File manager
# sudo pacman -S --noconfirm pcmanfm # it's ok only nautilus
sudo pacman -S --noconfirm filezilla

# Browser
sudo pacman -S --noconfirm chromium
sudo pacman -S --noconfirm firefox
sudo pacman -S --noconfirm opera
yay -S --noconfirm google-chrome

# Backup & security
sudo pacman -S --noconfirm deja-dup
yay -S --noconfirm megasync
sudo pacman -S --noconfirm gufw

# Editor & dev tool
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm vnote
yay -S --noconfirm postman-bin
sudo pacman -S --noconfirm wireshark-qt
sudo pacman -S --noconfirm gimp

# Others
sudo pacman -S --noconfirm gparted
sudo pacman -S --noconfirm xpad
yay -S --noconfirm spotify
sudo pacman -S --noconfirm thunderbird
# yay -S mendeleydesktop

# Communication
yay -S --noconfirm skypeforlinux-stable-bin
yay -S --noconfirm slack-desktop
yay -S --noconfirm zoom
sudo pacman -S --noconfirm telegram-desktop
yay -S --noconfirm discord

