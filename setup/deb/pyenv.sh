#!/bin/bash

# ref: https://github.com/pyenv/pyenv/wiki/Common-build-problems

sudo apt install -y libedit-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src


