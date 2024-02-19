#!/bin/bash

sudo apt update
sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# install ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# how to install ruby
#
# 1. rbenv install 3.2.1
# 1. rbenv global 3.2.1

