#!/bin/bash

# ref https://unix.stackexchange.com/questions/363048/unable-to-locate-package-docker-ce-on-a-64bit-ubuntu
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt update
sudo apt install docker-ce -y

# docker-compose
# ref https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04#conclusion
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# add me to docker group
sudo groupadd docker
sudo gpasswd -a mike docker
sudo systemctl restart docker
# exit

