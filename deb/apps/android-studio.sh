#!/bin/bash

[ -d "$HOME/.local/share/android-studio" ] && dpkg-query -W -f='${Status}' scrcpy 2>/dev/null | grep -q "install ok installed" && { echo "android-studio: already installed, skipping"; exit 0; }

# Android Studio - download tar.gz from Google (no official deb repo)

INSTALL_DIR="$HOME/.local/share/android-studio"
DESKTOP_FILE="$HOME/.local/share/applications/android-studio.desktop"

LATEST_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/stable/android-studio-linux.tar.gz"

mkdir -p "$INSTALL_DIR"
wget -O /tmp/android-studio.tar.gz "$LATEST_URL"
tar -xzf /tmp/android-studio.tar.gz -C "$INSTALL_DIR" --strip-components=1
rm /tmp/android-studio.tar.gz

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec=$INSTALL_DIR/bin/studio
Icon=$INSTALL_DIR/bin/studio.png
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-studio
EOF

echo "Android Studio installed to $INSTALL_DIR"

# scrcpy - Android screen mirroring
sudo apt install -y scrcpy
