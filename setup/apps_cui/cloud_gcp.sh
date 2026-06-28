#!/bin/bash
# Google Cloud CLI installation

set -e

echo "Installing Google Cloud CLI..."

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null

sudo apt update
sudo apt install -y google-cloud-cli

echo "Google Cloud CLI installed. Run 'gcloud init' to configure it."
