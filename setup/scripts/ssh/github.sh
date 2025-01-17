#!/bin/bash

# Usage
#
# 1. bash github.sh
# 1. paste public key to github
# 1. ssh -T git@github
# 1. ssh -T git@github.com
# 1. git config --global user.name "Your Name"
# 1. git config --global user.email "you@example.com"
#
# ref: https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt

mkdir -p ~/.ssh/
cd ~/.ssh/
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_xxx_rsa <<<y >/dev/null 2>&1

sudo chmod -R 700 ~/.ssh/
sudo chmod 600 ~/.ssh/id_xxx_rsa

cat >> config <<EOF
Host github github.com
    HostName            github.com
    IdentityFile        ~/.ssh/id_xxx_rsa
EOF
cat ~/.ssh/id_xxx_rsa.pub
