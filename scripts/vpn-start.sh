#!/bin/bash

# NOTE: need to exec cmd like below
# $ sudo direnv exec . bash vpn-start.sh

wget -qO- http://ipv4.icanhazip.com; echo # current ip address

# ipsec statu
ipsec up myvpn # start ipsec
echo "c myvpn" > /var/run/xl2tpd/l2tp-control # start l2tp
# ifconfig # confim whether ppp0(Point-to-Point Protocol) exits or not
# ip route # check default route
DEFAULT_GW=$(python3 gw_addr.py)
route add $VPN_SERVER_IP gw $DEFAULT_GW # replace default route; 192.168.0.1 is gateway ip, it appeared by `default via X.X.X.X ....`
route add default dev ppp0 # Add a new default route to start routing traffic via the VPN server

wget -qO- http://ipv4.icanhazip.com; echo # new ip address
