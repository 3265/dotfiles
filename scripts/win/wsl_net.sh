#!/bin/bash

# ref: https://github.com/microsoft/WSL/issues/5420#issuecomment-1204015091

# update WSL2 settings
# sudo bash -c 'echo "[network]" >> ~.wslconf'
# sudo bash -c 'echo "generateResolvConf = false" >> ~.wslconf'

# Update DNS settings
# NOTE:  I will oeverride the default nameserver 172.31.80.1 because this is the reason why curl times out sometimes.
sudo bash -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'
sudo bash -c 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf'

