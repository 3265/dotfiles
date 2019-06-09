#!/bin/sh

conky -d -c ~/dotfiles/conky/conky-sys
conky -d -c ~/dotfiles/conky/conky-time
conky -d -c ~/dotfiles/conky/conky-news
conky -d -c ~/dotfiles/conky/conky-profile
conky -d -c ~/dotfiles/conky/conky-gcal
conky -d -c ~/dotfiles/conky/conky-cal

# a way to convert old conky to new conky below
# NOTE: before to use it, need to install lua 5.3 and add permission to exec script and replace hashbang
# sudo /usr/share/doc/conky-all/convert.lua .conkyrc
