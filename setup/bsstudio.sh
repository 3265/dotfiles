#!/bin/bash

wget "https://bootstrapstudio.io/releases/desktop/4/Bootstrap%20Studio%204%20(64bit).tar.gz"
tar -xzvf 'Bootstrap Studio 4 (64bit).tar.gz' --remove-files
sudo mv -r ./Bootstrap\ Studio /opt/Bootstrap\ Studio
sudo ln -s /opt/Bootstrap\ Studio/Bootstrap\ Studio /usr/bin/bsstudio

