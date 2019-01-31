#!/bin/bash

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
