#!/bin/bash

APPDIR=/opt/notesnook
APPIMAGE="$APPDIR/notesnook.AppImage"

[ -f "$APPIMAGE" ] && { echo "notesnook: already installed, skipping"; exit 0; }

# Notesnook - GitHub releases, Linux only ships as an AppImage (no apt repo, no .deb)
LATEST=$(curl -s https://api.github.com/repos/streetwriters/notesnook/releases/latest \
  | grep -Po '"tag_name": "v\K[^"]*')

sudo mkdir -p "$APPDIR"
sudo curl -L -o "$APPIMAGE" "https://github.com/streetwriters/notesnook/releases/download/v${LATEST}/notesnook_linux_x86_64.AppImage"
sudo chmod +x "$APPIMAGE"

# AppImages don't register themselves - pull the bundled icon out so the
# launcher entry below isn't blank, then write the .desktop file ourselves.
TMPDIR=$(mktemp -d)
(cd "$TMPDIR" && "$APPIMAGE" --appimage-extract usr/share/icons/hicolor/256x256/apps/notesnook.png >/dev/null)
sudo install -Dm644 "$TMPDIR/squashfs-root/usr/share/icons/hicolor/256x256/apps/notesnook.png" \
  /usr/share/icons/hicolor/256x256/apps/notesnook.png
rm -rf "$TMPDIR"

sudo tee /usr/share/applications/notesnook.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Notesnook
Exec=$APPIMAGE %U
Terminal=false
Type=Application
Icon=notesnook
StartupWMClass=Notesnook
Comment=Your private note taking space
MimeType=x-scheme-handler/nn;
Categories=Office;
EOF
