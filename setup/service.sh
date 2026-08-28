#!/bin/bash
set -e

########################
#  system services
########################

sudo cp "/home/mike/dotfiles/setup/systemd/system/nvidia-power-limit.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia-power-limit.service

########################
#  user services
########################

mkdir -p ~/.config/systemd/user/
ln -s -f ~/dotfiles/setup/systemd/user/fusuma.service ~/.config/systemd/user/fusuma.service
ln -s -f ~/dotfiles/setup/systemd/user/dashboard.service ~/.config/systemd/user/dashboard.service

systemctl --user daemon-reload
systemctl --user enable --now fusuma.service
systemctl --user enable --now dashboard.service

# dashboard serves on this port
sudo ufw allow 6001
