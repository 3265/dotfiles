#!/bin/bash
# Cloud tools installation

echo "Installing Cloud tools..."
sudo apt install -y awscli
npm install -g aws-cdk
pip install --user aws-sam-cli
