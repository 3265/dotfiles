#!/bin/bash

sudo apt update
sudo apt install build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# install ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# install ruby
rbenv install 3.2.1
rbenv global 3.2.1

