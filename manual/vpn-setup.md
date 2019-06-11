NOTE: this memo is VPN of L2TP/IPSec PSK  
based on https://github.com/hwdsl2/setup-ipsec-vpn  
and network-manager-l2tp-gnome was not working for me that's why i used vpn cmd manually.

# make .envrc

```
$ cp .env .envrc
```

# check IEK algorithm type

result was below in my vpn server
it means IKE algorithm is aes128-sha1-modp1024!

```
$ sudo ike-scan $VPN_SERVER_IP --trans="(1=7,14=128,2=2,3=1,4=2)"
XXX.XXX.XXX.XXX  Main Mode Handshake returned HDR=(CKY-R=5911387ba9cc4c1e) SA=(Enc=AES KeyLength=128 Hash=SHA1 Group=2:modp1024 Auth=PSK LifeType=Seconds LifeDuration=1800)
```

# to load vpn credential 

```
$ cd ~/dotifiles
$ sudo direnv allow && sudo direnv exec . bash 
# echo $VPN_SERVER_IP
```

# run setup script

```
# sh script/vpn-setup.sh
```
