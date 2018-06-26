#!/bin/bash

# ######################
#  python
# ######################

sudo apt install python-pip python3-pip

pip3 install jupyter

pip3 install --upgrade pip
pip3 install flake8

# for tmux
pip3 install --user tmuxp

# for Refactoring
pip2 install codemod

pip3 install mycli
pip3 install httpie

# for REPL
pip3 install ipython
pip install ptpython

pip3 install neovim

# VimのPluginのALEで使うLint用
pip3 install flake8
