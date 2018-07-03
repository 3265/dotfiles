#!/bin/bash

mkdir -p ~/.ssh/
cd ~/.ssh/
ssh-keygen -t rsa #パスフレ無し
$EDITOR ~/.ssh/config #以下の設定内容を貼り付け
sudo chmod -R 700 ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
