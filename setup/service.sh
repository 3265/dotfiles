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
ln -s -f ~/dotfiles/setup/systemd/user/index.service ~/.config/systemd/user/index.service
ln -s -f ~/dotfiles/setup/systemd/user/dashboard.service ~/.config/systemd/user/dashboard.service
ln -s -f ~/dotfiles/setup/systemd/user/explorer.service ~/.config/systemd/user/explorer.service

systemctl --user daemon-reload
systemctl --user enable --now fusuma.service
systemctl --user enable --now index.service
systemctl --user enable --now dashboard.service
systemctl --user enable --now explorer.service

# index, dashboard, and explorer serve on these ports
sudo ufw allow 6001
sudo ufw allow 6002
sudo ufw allow 6003
