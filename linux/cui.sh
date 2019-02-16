#!/bin/bash

# Terminal
sudo pacman -S --noconfirm bash zsh mosh parallel translate-shell

# Editor
sudo pacman -S --noconfirm vim neovim emacs

# Finder with UI
sudo pacman -S --noconfirm ranger vifm

# Finder
sudo pacman -S --noconfirm donethe_silver_searcher

# Additional keyboard shortcut
# use xbindkeys to avod to depend desktop environment
sudo pacman -S --noconfirm xbindkeys

# Monitoring
sudo pacman -S --noconfirm htop powertop

# Downloader
sudo pacman -S --noconfirm curl wget

# Tools

# Virtualization
<< __EOF__
# add mike to docker group
sudo groupadd docker
sudo gpasswd -a mike docker
sudo systemctl restart docker
__EOF__
sudo pacman -S --noconfirm virtualbox vagrant docker docker-compose

# VPN
sudo pacman -S --noconfirm strongswan xl2tpd
yay -S --noconfirm ike-scan

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
# NOTE: xsel is for yank
sudo pacman -S --noconfirm screen tmux xsel

# VCS
sudo pacman -S --noconfirm git tig

# Todo Manager
sudo pacman -S --noconfirm task
yay -S --noconfirm tasksh vit

# Screensaver
sudo pacman -S --noconfirm cmatrix

# Tools
# NOTE: net-tools is for ifconfig
sudo pacman -S --noconfirm tree nmap net-tools alsa-utils
yay -S --noconfirm direnv peco pet-bin

# Cloud CLI
sudo pacman -S --noconfirm aws-cli
yay -S --noconfirm google-cloud-sdk

# lang
yay -S --noconfirm terraform

# Font
# ref https://nerdfonts.com/
sudo pacman -S --noconfirm gucharmap
yay -S --noconfirm nerd-fonts-hack

# For temperature
sudo pacman -S --noconfirm lm_sensors

# A command-line based markdown presentation tool.
yay -S --noconfirm mdp

# Music player
sudo pacman -S --noconfirm mpd
systemctl start mpd
systemctl enable mpd
# yay -S --noconfirm vimpc-git

# Screen recorder
sudo pacman -S --noconfirm asciinema
