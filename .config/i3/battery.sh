#!/bin/bash

# NOTE: need to install acpitool
BATTINFO=`acpitool -b`
CHARGING=`echo $BATTINFO | grep Discharging`
REMAINING=`echo $BATTINFO | tail -c 8`
DT1=`date -d "$REMAINING" '+%s'`
DT2=`date -d "00:15:00" '+%s'`

if [[ $CHARGING && $DT1 -lt  $DT2 ]] ; then
    # cronから実行するため環境変数DISPLAYをつける
    DISPLAY=:0 notify-send -u critical "Low Battery" "$BATTINFO"
fi
