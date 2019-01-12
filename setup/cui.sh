#!/bin/bash

apt update
apt install sudo -y

# FileSystem
apt install zfs -y

# Terminal
apt install bash -y
apt install zsh -y
apt install mosh -y
apt install pssh -y # includes prsync, pscp
apt install translate-shell

# Editor
apt install vim -y
apt install neovim -y
apt install vim-gnome -y # to use clipboard
apt install emacs -y

# Finder
apt install ranger -y
apt install silversearcher-ag -y

# Dictionary
apt install goldendict -y
apt install waei -y

# Additional keyboard shortcut
apt install xbindkey -y

# Monitoring
apt install htop -y
apt install powertop -y

# Downloader
apt install curl -y
apt install wget -y

# Virtualization
apt install virtualbox -y
apt install vagrant -y
apt install docker-ec -y

# VPN
apt install ike-scan -y
apt install strongswan -y
apt install xl2tpd -y

# KVM
# NOTE: Need to reboot
# apt-get install qemu-kvm -y # emulator
# apt-get install libvirt-bin -y
# apt-get install libvirt0 -y
# apt-get install libvirt-bin -y
# apt-get install virt-install -y # cli
# apt-get install virt-manager -y
# apt-get install bridge-utils -y # for virtual bridge

# Terminal multiplexer
apt install screen -y
apt install tmux -y
apt install xsel -y # for yank

# VCS
apt install git -y
apt install tig -y

# Todo Manager
apt install taskwarrior -y
apt install tasksh -y
apt install vit -y

# Screensaver
apt install cmatrix -y

# Tools
apt install direnv -y
apt install peco -y
apt install tree -y
apt install gdebi -y
apt install nmap -y
apt install net-tools -y # for ifconfig
