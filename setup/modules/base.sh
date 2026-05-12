#!/bin/bash
# Base packages installation using apt

sudo apt update
sudo apt install -y \
  build-essential \
  cmake \
  silversearcher-ag \
  ripgrep \
  tree \
  fzf \
  bat \
  xsel \
  xclip \
  autojump \
  direnv \
  zip \
  unzip \
  net-tools \
  cmatrix \
  apache2-utils \
  whois \
  curl \
  inxi \
  htop \
  lsd

sudo apt install -y python-is-python3
cargo install fastmod
go install github.com/x-motemen/ghq@latest
