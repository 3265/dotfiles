#!/bin/bash

# NOTE:
# - curl と xml2 のインスコが必要
# - conkyのrssコマンドが改行してくれないため
# - foldで頭数字で改行されるとsedで置き換えているところで空白詰められない気がする
max_line=50;count=1
curl -sL ${1} | xml2 | grep "item/title" | awk -F'=' '{print $2}' | head --line=${count} | nl -n ln | fold -s -${max_line} | sed '/^[^0-9]/s/^/       /g'

