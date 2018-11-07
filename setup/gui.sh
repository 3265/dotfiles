#!/bin/bash

sudo apt-get update

# WM
sudo apt-get install i3 -y
sudo apt-get install feh -y # for wallpaper
sudo apt-get install compton -y # for transparent
sudo apt-get install parcellite -y # for clip board
sudo apt-get install volumeicon-alsa -y # to use volumeicon
sudo apt-get install scrot -y # screenshot
sudo apt-get install shutter -y # rectangle screenshot
sudo apt-get install acpitool -y # to manage battery
sudo apt-get install xautolock -y # for auto lock
sudo apt-get install network-manager-openvpn-gnome # for VPN
sudo apt-get install redshift gtk-redshift -y # for blue light

# Launcher
sudo apt install rofi -y
sudo apt install qalc -y # for calculation

# Browser
sudo apt-get install chromium-browser -y
sudo apt-get install firefox -y
sudo apt-get install qutebrowser -y

# Office
sudo apt-get install libreoffice -y
sudo apt-get install impressive -y

# Video Player
sudo apt-get install vlc -y

# Touchpad Gesture
# see fusuma.sh

# Conky
sudo apt-get install conky-all -y # to use rss
sudo apt-get install moc moc-ffmpeg-plugin -y # for Music
sudo apt-get install net-tools -y # for ifconfig(used by conky-info)
sudo apt-get install lm-sensors -y # for sensors in conky
sudo apt-get install neofetch -y # cli sys info tool
sudo apt-get install gcalcli -y # google calendar cli
# need to auth before use it using cmd below
# gcalcli --noauth_local_webserver
sudo apt-get install xml2 -y # parse xml for rss

# RSS Reader
# sudo apt-get install newsboat -y # for rss cause rss of conky does not break a new line

# Firewall
sudo apt-get install ufw -y
sudo apt-get install gufw -y

# Anti virus
sudo apt-get install clamav -y
sudo apt-get install clamtk -y

# Business
sudo snap install skype --classic

# Tools
sudo apt-get install wireshark -y
# Way to solve permission err of wireshark
# see https://ubuntuforums.org/showthread.php?t=2039978

# Manual
# vs code
# slack
# toggl
# ngrok
# Postman
