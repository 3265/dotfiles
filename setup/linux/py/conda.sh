#!/bin/bash

# ref: https://repo.anaconda.com/archive/

wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
# options
# ref: https://stackoverflow.com/questions/49865531/bash-script-for-anaconda-installer-and-license-agreement
bash ./Anaconda3-2023.09-0-Linux-x86_64.sh -b -p $HOME/anaconda3
rm -f ./Anaconda3-2023.09-0-Linux-x86_64.sh
