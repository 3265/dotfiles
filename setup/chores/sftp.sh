#!/bin/bash

set -e

sudo ufw allow 22
sudo systemctl enable --now ssh

ip=$(hostname -I | awk '{print $1}')
echo "SFTP ready -> sftp $(whoami)@${ip}"
