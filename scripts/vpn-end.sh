#!/bin/bash

# NOTE: have to be sudoers
ipsec down myvpn
echo "d myvpn" > /var/run/xl2tpd/l2tp-control
route del default dev ppp0

# just in case
service strongswan restart
service xl2tpd restart

