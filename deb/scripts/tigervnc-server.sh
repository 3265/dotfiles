#!/bin/bash

# sudo apt install tigervnc-scraping-server
# sudo apt install tigervnc-standalone-server
# sudo apt install ufw

sudo ufw enable
sudo ufw allow 5900
sudo ufw status

ip -4 address

pkill -9 -f x0tigervncserver
pkill -9 -f x0tigervnc

sleep 1

#xauth merge /run/user/1000/gdm/Xauthority
x0tigervncserver -display :1 -rfbport 5900 -SecurityTypes None -localhost=0 --I-KNOW-THIS-IS-INSECURE

x0tigervncserver -list
