#!/bin/bash

# Install Nix

bash -c "sh <(curl -L https://nixos.org/nix/install) --no-daemon"
. ~/.nix-profile/etc/profile.d/nix.sh

# Activate Flakes

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
