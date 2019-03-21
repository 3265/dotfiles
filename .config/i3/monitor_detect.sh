#!/bin/bash

#st_prev=$(cat /sys/class/drm/card0-HDMI-A-1/status)
st_prev="disconnected"

while :
do
    st_next=$(cat /sys/class/drm/card0-HDMI-A-1/status)
    if [ $st_prev != $st_next ]; then
        st_prev=$st_next
        if [ $st_next = "connected" ]; then
            xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --auto --above eDP1
        else
            xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --off
        fi
        bash ~/dotfiles/.config/polybar/launch.sh
        feh --bg-center ~/dotfiles/images/silver_lining.jpg --image-bg black # wallpaper
    fi
    sleep 1
done

