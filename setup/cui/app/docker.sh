#!/bin/bash

sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo apt install docker-compose-plugin -y
sudo usermod -aG docker $USER
newgrp docker
docker ps

# reboot
