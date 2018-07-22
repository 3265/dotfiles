#!/bin/bash

# NOTE: need to install acpitool
BATTINFO=`acpitool -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | tail -c 8` < 00:15:00 ]] ; then
    MSG="Low Battery"
    # cronから実行するため環境変数DISPLAYをつける
    DISPLAY=:0 notify-send -u critical "$MSG" "$BATTINFO"
fi
