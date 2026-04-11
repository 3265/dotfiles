#!/bin/bash

INSTALL_DIR="$HOME/.local/share/flutter"

[ -d "$INSTALL_DIR" ] && { echo "flutter: already installed, skipping"; exit 0; }

# Flutter - download tar.gz from Google (no official deb repo)
LATEST=$(curl -s https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json \
  | grep -Po '"version": "\K[^"]*' | head -1)

wget -O /tmp/flutter.tar.xz \
  "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${LATEST}-stable.tar.xz"

mkdir -p "$INSTALL_DIR"
tar -xf /tmp/flutter.tar.xz -C "$INSTALL_DIR" --strip-components=1
rm /tmp/flutter.tar.xz

echo "Flutter installed to $INSTALL_DIR"
echo "Add to PATH: export PATH=\"\$PATH:$INSTALL_DIR/bin\""
