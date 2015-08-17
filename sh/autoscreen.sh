#!/sh/bash
screen -q -ls
if [ $? -ne 9 -a -z "$STY" ]; then
  screen -q -ls↲
        if [ $? -eq 9 ]; then
                 screen
        else
                screen -xR
        fi
fi
