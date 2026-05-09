#!/bin/bash

set -e

sudo apt install -y openssh-server

sudo tee /etc/ssh/sshd_config.d/00-localhost-password.conf >/dev/null <<'EOF'
ListenAddress 127.0.0.1
ListenAddress ::1
PasswordAuthentication yes
KbdInteractiveAuthentication yes
UsePAM yes
PermitRootLogin no
EOF

sudo sshd -t
sudo systemctl enable --now ssh
sudo systemctl restart ssh

echo "Check:"
sudo sshd -T | grep -Ei '^(listenaddress|passwordauthentication|kbdinteractiveauthentication|usepam|permitrootlogin)'
