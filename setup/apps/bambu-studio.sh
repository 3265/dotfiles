#!/bin/bash

flatpak list --app 2>/dev/null | grep -q "com.bambulab.BambuStudio" && { echo "bambu-studio: already installed, skipping"; exit 0; }

# Bambu Studio - Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.bambulab.BambuStudio
