#!/bin/bash

apt-get update
apt-get install sudo -y

# FileSystem
apt-get install zfs -y

# Terminal
apt-get install bash -y
apt-get install zsh -y
apt-get install mosh -y
apt-get install pssh -y # includes prsync, pscp

# Editor
apt-get install vim -y
apt-get install nvim -y
apt-get install vim-gnome -y # to use clipboard
apt-get install emacs -y

# Finder
apt-get install ranger -y
apt-get install silversearcher-ag -y

# Dictionary
apt-get install waei -y

# Monitoring
apt-get install htop -y
apt-get install powertop -y

# Downloader
apt-get install curl -y
apt-get install wget -y

# Virtualization
apt-get install docker-ec -y
apt-get install virtualbox -y
apt-get install vagrant -y

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
apt-get install tmux -y
apt-get install xsel -y # for yank
apt-get install screen -y

# VCS
apt-get install git -y
apt-get install tig -y

# Todo Manager
apt-get install taskwarrior -y
apt-get install tasksh -y
apt-get install vit -y

# Screensaver
apt-get install cmatrix -y

# Tools
apt-get install tree -y
apt-get install gdebi -y
apt-get install nmap -y
