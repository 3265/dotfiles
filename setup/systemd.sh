#!/bin/bash
set -e

sudo cp "/home/mike/dotfiles/setup/system/nvidia-power-limit.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia-power-limit.service
