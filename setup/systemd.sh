#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")/../.." && pwd)"

sudo cp "$DOTFILES/setup/system/nvidia-power-limit.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia-power-limit.service
