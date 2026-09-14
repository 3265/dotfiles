#!/bin/bash

if flatpak list --app 2>/dev/null | grep -q org.openrgb.OpenRGB; then
    echo "openrgb: already installed, skipping"
else
    # OpenRGB - not in apt, install via Flathub
    flatpak install -y flathub org.openrgb.OpenRGB
fi

# Needs udev rules for non-root USB access to RGB controllers (e.g. this
# machine's HP TracerLED case lighting), otherwise most devices go undetected.
# Checked separately from the install above since this step can still be
# missing even when OpenRGB itself is already installed.
if [ -f /etc/udev/rules.d/60-openrgb.rules ]; then
    echo "openrgb: udev rules already installed, skipping"
else
    flatpak run org.openrgb.OpenRGB --print-udev-rules | sudo tee /etc/udev/rules.d/60-openrgb.rules > /dev/null
    sudo udevadm control --reload-rules
    sudo udevadm trigger
fi
