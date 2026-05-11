#!/bin/bash

set -e

MOSH_PORT_RANGE="60000:61000/udp"

sudo apt install -y mosh

if ! command -v ufw >/dev/null 2>&1; then
    sudo apt install -y ufw
fi

sudo ufw allow OpenSSH
sudo ufw allow "${MOSH_PORT_RANGE}"
sudo ufw --force enable
sudo ufw status verbose
