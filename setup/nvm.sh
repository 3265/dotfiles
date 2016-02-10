#!/bin/bash

git clone git://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
nvm install v0.12.0
nvm alias default v0.12.0 default
nvm use default
