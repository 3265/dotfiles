#!/bin/sh

i3-nagbar -t warning -m 'Menu of i3' \
-b 'Shutdown' 'systemctl poweroff' \
-b 'Reboot' 'systemctl reboot' \
-b 'Logout' 'i3-msg exit' \
-b 'Lock' 'i3lock -c 000000' \
-b 'Suspend' 'systemctl suspend'

