# FOR IME
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”

# For custom key mapping
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# For GUI
exec i3 # startkde
