#!/bin/sh

# REF: https://kaustubh13.medium.com/how-to-install-cling-on-linux-or-wsl-8125798ed9b9

sudo apt install -y wget unar
wget https://root.cern/download/cling/cling_2020-11-05_ROOT-ubuntu2004.tar.bz2
unar ./cling_2020-11-05_ROOT-ubuntu2004.tar.bz2 
./cling_2020-11-05_ROOT-ubuntu2004/bin/cling
mv cling_2020-11-05_ROOT-ubuntu2004 ~/root
