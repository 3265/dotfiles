#!/bin/bash

apt install -y libssl-dev libreadline-dev

# see https://github.com/rbenv/rbenv-installer
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

# cmds below needed to install ruby and rails
# apt install -y libssl-dev libreadline-dev zlib1g-dev
# apt install -y libxml2-dev1
# apt install libpq-dev

# which ruby
# rbenv install
# gem install bundler
# rbenv rehash
# bundle

# cat Gemfile.lock
# gem install bundler -v 1.17.1
