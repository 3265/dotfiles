#!/bin/bash

FOLDER=gaze_linux_v1.1.0

wget https://github.com/wtetsu/gaze/releases/download/v1.1.0/${FOLDER}.zip
unzip ${FOLDER}.zip
sudo mv ${FOLDER}/gaze /usr/local/bin
sudo chmod +x /usr/local/bin/gaze
rm -rf ${FOLDER}.zip ${FOLDER}

