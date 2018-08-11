#!/bin/sh

xrandr --output LVDS-1 --output HDMI-1 --auto --above LVDS-1 # monitor position; need to check display name by using xrandr
feh --bg-center ~/dotfiles/i3/wallpaper.jpeg --image-bg #000000 # wallpaper
