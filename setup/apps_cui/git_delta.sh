#!/bin/bash

wget https://github.com/dandavison/delta/releases/download/0.19.2/git-delta_0.19.2_amd64.deb
sudo apt install ./git-delta_0.19.2_amd64.deb
rm ./git-delta_0.19.2_amd64.deb 
delta --version

#####################
#    git settings   #
#####################
#
# git config --global core.pager delta
# git config --global interactive.diffFilter 'delta --color-only'
# git config --global delta.navigate true
# git config --global delta.side-by-side true
# git config --global delta.line-numbers true
