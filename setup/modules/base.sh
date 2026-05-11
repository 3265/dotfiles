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
  lsd \
  fastmod \
  ghq
