#!/bin/bash

# Patches the installed Simplenote app.asar so the menu bar stays hidden
# permanently, instead of toggling on Alt. mainWindow.setAutoHideMenuBar()
# is a documented no-op on Linux, but mainWindow.setMenuBarVisibility(false)
# actually works and isn't re-shown by Alt - so this forces that call
# regardless of what the in-app "Menu Bar" setting sends. Re-run after any
# Simplenote update, since updates overwrite app.asar and drop the patch.

ASAR=/opt/Simplenote/resources/app.asar

grep -aqF "mainWindow.setAutoHideMenuBar(false);" "$ASAR" 2>/dev/null && { echo "simplenote: already patched, skipping"; exit 0; }

TMPDIR=$(mktemp -d)
npx --yes asar extract "$ASAR" "$TMPDIR/app"

sed -i \
  -e "s/mainWindow.setAutoHideMenuBar(autoHideMenuBar || false);/mainWindow.setAutoHideMenuBar(false);/" \
  -e "s/mainWindow.setMenuBarVisibility(!autoHideMenuBar);/mainWindow.setMenuBarVisibility(false);/" \
  "$TMPDIR/app/desktop/app.js"

npx --yes asar pack "$TMPDIR/app" "$TMPDIR/app.asar"
if sudo cp "$TMPDIR/app.asar" "$ASAR"; then
    rm -rf "$TMPDIR"
    echo "simplenote: patched, restart the app for the menu bar to stay hidden"
else
    echo "simplenote: patched build left at $TMPDIR/app.asar - copy it to $ASAR yourself (e.g. sudo cp $TMPDIR/app.asar $ASAR)"
    exit 1
fi
