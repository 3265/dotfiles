#!/bin/sh

PRIMARY=$(xrandr | grep "connected primary" | awk '{ print$1   }')
xrandr --output $PRIMARY --output HDMI1 --auto --above $PRIMARY # monitor position; need to check display name by using xrandr
feh --bg-center ~/dotfiles/i3/wallpaper.jpeg --image-bg black # wallpaper
