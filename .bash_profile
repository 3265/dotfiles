if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

if [ -f ~/.zshenv ]; then
    . ~/.zshenv
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

