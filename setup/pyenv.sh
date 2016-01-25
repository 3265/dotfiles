#!/bin/bash

# for linux
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
curl -kL https://bootstrap.pypa.io/get-pip.py | python
sudo python get-pip.py

# for os x
brew install readline


