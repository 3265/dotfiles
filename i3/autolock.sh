#!/bin/sh

# NOTE:
# - need to install xautolock
xautolock -time 1 -locker "i3lock --color 000000" -killer "systemctl suspend" -killtime 20 &

