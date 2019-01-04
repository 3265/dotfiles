#!/bin/bash

apt update

# WM
apt install i3 -y
apt install feh -y # for wallpaper
apt install compton -y # for transparent
apt install parcellite -y # for clip board
apt install volumeicon-alsa -y # to use volumeicon
apt install scrot -y # screenshot
apt install shutter -y # rectangle screenshot
apt install acpitool -y # to manage battery
apt install xautolock -y # for auto lock
apt install network-manager-openvpn-gnome # for VPN
apt install redshift gtk-redshift -y # for blue light

# gparted

# Launcher
apt install rofi -y
apt install qalc -y # for calculation

# Browser
apt install chromium-browser -y
apt install firefox -y
apt install qutebrowser -y

# Office
apt install libreoffice -y
apt install impressive -y

# Video Player
apt install vlc -y

# Touchpad Gesture
# see fusuma.sh

# Conky
apt install conky-all -y # to use rss
apt install moc moc-ffmpeg-plugin -y # for Music
apt install net-tools -y # for ifconfig(used by conky-info)
apt install lm-sensors -y # for sensors in conky
apt install neofetch -y # cli sys info tool
apt install gcalcli -y # google calendar cli
# need to auth before use it using cmd below
# gcalcli --noauth_local_webserver
apt install xml2 -y # parse xml for rss

# RSS Reader
# sudo apt-get install newsboat -y # for rss cause rss of conky does not break a new line

# Firewall
apt install ufw -y
apt install gufw -y

# Anti virus
apt install clamav -y
apt install clamtk -y

# Business
snap install skype --classic

# Tools
apt install wireshark -y
# Way to solve permission err of wireshark
# see https://ubuntuforums.org/showthread.php?t=2039978

# Manual
# vs code
# slack
# toggl
# ngrok
# Postman
