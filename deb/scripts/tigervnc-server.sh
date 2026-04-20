#!/bin/bash

# sudo apt install tigervnc-scraping-server
# sudo apt install tigervnc-standalone-server

ip -4 address

pkill x0tigervncserver
xauth merge /run/user/1000/gdm/Xauthority
x0tigervncserver -display :1 -rfbport 5900 -SecurityTypes None

