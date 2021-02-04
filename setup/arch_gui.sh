#!/bin/bash

# X.org
sudo pacman -S --noconfirm xorg-xmodmap

# terminal
# sudo pacman -S --noconfirm termite
sudo pacman -S --noconfirm terminator
# sudo pacman -S --noconfirm alacritty

# IME
# 設定は次の通り。
# - Active Key: RALT
# - Inactive Key: LALT
# NOTE:
# - RALTがGnome 3のAlternate Character Keyとかぶるのでそれを変える必要がある。
# - これを変更せずに作業するとGUIのフリーズを招くので要注意。
sudo pacman -S --noconfirm fcitx fcitx-mozc fcitx-configtool
sudo pacman -S --noconfirm fcitx-im
# sudo pacman -S fcitx-gtk2 fcitx-gtk3 fcitx-qt5
# yay -S fcitx-qt4

# Launcher
sudo pacman -S --noconfirm xbindkeys # For add shortcut of rofi
sudo pacman -S --noconfirm rofi

# Gnome Tools
sudo pacman -S --noconfirm gnome-tweaks
# yay -S --noconfirm yaru-gtk-theme
# yay -S --noconfirm yaru-sound-theme
yay -S --noconfirm gnome-shell-extension-clipboard-indicator-git # clipboard
yay -S --noconfirm gnome-shell-extension-caffeine-plus-git # caffeine
yay -S --noconfirm gnome-shell-extension-gsconnect # connect to Android
yay -S --noconfirm gnome-shell-extension-system-monitor-git
# yay -S --noconfirm gnome-shell-extension-unite
# yay -S --noconfirm gnome-shell-pomodoro
# yay -S --noconfirm gnome-shell-extension-easyscreencast # I got memory leak from this app maybe...

# File manager
# sudo pacman -S --noconfirm pcmanfm # it's ok only nautilus
# sudo pacman -S --noconfirm filezilla
sudo pacman -S --noconfirm dolphin

# Browser
# sudo pacman -S --noconfirm chromium
yay -S --noconfirm google-chrome
# yay -S --noconfirm brave
# sudo pacman -S --noconfirm firefox
# sudo pacman -S --noconfirm opera

# Backup
sudo pacman -S --noconfirm deja-dup
# yay -S --noconfirm megasync

# Editor & dev tool
sudo pacman -S --noconfirm wmctrl # for GlassIt Linux
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm vnote-bin
yay -S --noconfirm postman-bin
yay -S --noconfirm appimagelauncher # for appImage
sudo pacman -S --noconfirm arduino-avr-core
sudo pacman -S --noconfirm arduino
sudo pacman -S --noconfirm gimp
sudo pacman -S --noconfirm graphviz # for dot file
# sudo pacman -S --noconfirm wireshark-qt
# yay -S --noconfirm panoply # HDF5 Viewer
# sudo pacman -S --noconfirm poedit
# yay -S --noconfirm acroread # PDF Viewer

# Others
sudo pacman -S --noconfirm gparted
# sudo pacman -S --noconfirm xpad
# sudo pacman -S --noconfirm xsensors
# yay -S --noconfirm spotify
# sudo pacman -S --noconfirm thunderbird
sudo pacman -S --noconfirm goldendict
# yay -S --noconfirm zotero
sudo pacman -S --noconfirm simplescreenrecorder
# yay -S mendeleydesktop

# Communication
yay -S --noconfirm skypeforlinux-stable-bin
yay -S --noconfirm slack-desktop
yay -S --noconfirm zoom
# sudo pacman -S --noconfirm telegram-desktop
# yay -S --noconfirm discord


# For Kindle
# sudo pacman -S --noconfirm wine

# Live OS writer
yay -S etcher-bin

# VLC
sudo pacman -S --noconfirm vlc
