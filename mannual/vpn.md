# Setup L2TP/IPSec

TODO

# Start L2TP/IPSec

## Firstly, need to start processes

```
$ /usr/bin/systemctl restart strongswan
$ /usr/bin/systemctl restart xl2tpd
```

## SWitch shell to use env

```
$ sudo direnv allow && sudo direnv exec . bash
```

## Start VPN

```
$ wget -qO- http://ipv4.icanhazip.com; echo # current ip address
$ 
$ ipsec up myvpn # start ipsec
$ echo "c myvpn" > /var/run/xl2tpd/l2tp-control # start l2tp
$ ifconfig # confim whether ppp0(Point-to-Point Protocol) exits or not
$ ip route # check default route
$ route add $VPN_SERVER_IP gw 192.168.0.1 # replace default route; 192.168.0.1 is gateway ip, it appeared by `default via X.X.X.X ....`
$ route add default dev ppp0 # Add a new default route to start routing traffic via the VPN server
$ 
$ wget -qO- http://ipv4.icanhazip.com; echo # new ip address
```

## finish VPN

```
$ route del default dev ppp0
$ echo "d myvpn" > /var/run/xl2tpd/l2tp-control
$ ipsec down myvpn
```
