# NOTE:
# For launch i3 window manager
# Need to setup default shell as /bin/bash in vertual console user
# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi

# if [ -f ~/.zshenv ]; then
#     . ~/.zshenv
# fi
#
# if [ -f ~/.bashrc ]; then
#     . ~/.bashrc
# fi

exec fish
