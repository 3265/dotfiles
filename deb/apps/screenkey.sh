#!/bin/bash

dpkg-query -W -f='${Status}' screenkey 2>/dev/null | grep -q "install ok installed" && { echo "screenkey: already installed, skipping"; exit 0; }

sudo apt install -y screenkey
