#!/bin/bash

flatpak list --app 2>/dev/null | grep -q "org.freecadweb.FreeCAD" && { echo "freecad: already installed, skipping"; exit 0; }

# FreeCAD 1.1.1 - Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.freecadweb.FreeCAD
