#!/bin/sh

# NOTE:
# - need to install xautolock
# xautolock -time 30 -locker "i3lock --color 000000" -killer "systemctl suspend" -killtime 20 &
xautolock -detectsleep \
  -time 3 -locker "light-locker-command -l" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"

