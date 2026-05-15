#!/bin/bash

set -e

echo "Setting Caps Lock → Ctrl system-wide..."

# Backup existing config
sudo cp /etc/default/keyboard /etc/default/keyboard.bak

# Update or add XKBOPTIONS
if grep -q "^XKBOPTIONS=" /etc/default/keyboard; then
    sudo sed -i 's/^XKBOPTIONS=.*/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
else
    echo 'XKBOPTIONS="ctrl:nocaps"' | sudo tee -a /etc/default/keyboard
fi

# Apply changes
sudo dpkg-reconfigure -f noninteractive keyboard-configuration
sudo systemctl restart keyboard-setup

echo "Done. You may want to reboot to ensure everything picks it up."
