#!/bin/bash

git clone git://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
source ~/.bashrc
nvm install v5.4.0
nvm alias default v5.4.0 default
nvm use default
