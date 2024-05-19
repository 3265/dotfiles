#!/bin/bash

# sudo bash -c 'echo "[network]" > /etc/wsl.conf'
# sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

