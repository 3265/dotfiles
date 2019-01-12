#!/bin/bash

version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | python3 -c 'import sys, json; print(json.load(sys.stdin)["current_version"])')
wget -N https://releases.hashicorp.com/terraform/$version/terraform_$version\_linux_amd64.zip -P ~/
unzip ~/terraform_$version\_linux_amd64.zip -d ~/

rm ~/terraform_$version\_linux_amd64.zip
sudo mv -f ~/terraform /usr/local/bin/terraform
sudo chown root:root /usr/local/bin/terraform
sudo chmod 0755 /usr/local/bin/terraform
