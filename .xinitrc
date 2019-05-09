# FOR IME
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”

# For custom key mapping
[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap

# For GUI
exec i3 # startkde
