#!/bin/bash

# code --install-extension > extensions.txt

cat extensions.txt | while read line
do
  code --install-extension $line
done



