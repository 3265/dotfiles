#!/bin/bash

set -e
 
ARCH=$(uname -m)


if [ "$ARCH" = "x86_64" ]; then
    echo "Detected x86_64 architecture."
    wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
    unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
    sudo ./sam-installation/install
    rm aws-sam-cli-linux-x86_64.zip 
    rm -rf sam-installation 
    rm awscliv2.zip
elif [ "$ARCH" = "aarch64" ]; then
    echo "TODO"
    exit 1
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Installation complete."

