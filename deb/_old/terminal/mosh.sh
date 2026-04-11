#!/bin/bash

set -e

MOSH_PORT_RANGE="60000:61000/udp"

sudo apt install -y mosh

if ! command -v ufw >/dev/null 2>&1; then
    sudo apt install -y ufw
fi

# `ufw allow` is safe even when UFW is installed but not enabled yet.
if ! sudo ufw status | grep -Fq "${MOSH_PORT_RANGE}"; then
    sudo ufw allow "${MOSH_PORT_RANGE}"
fi
