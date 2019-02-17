#!/bin/sh

PRIMARY=$(xrandr | grep "connected primary" | awk '{ print$1   }')
xrandr --output $PRIMARY --output HDMI1 --auto --above $PRIMARY # monitor position; need to check display name by using xrandr
bash ~/dotfiles/.config/polybar/launch.sh
feh --bg-center ~/dotfiles/images/wallpaper.jpg --image-bg black # wallpaper
