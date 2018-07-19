#!/bin/bash

# Note: need to add permission
# chmod +x ~/dotfiles/i3/empty_workspace.sh

# ref https://faq.i3wm.org/question/6004/creating-a-new-workspace.1.html
i3-msg workspace $(($(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1) + 1))
# i3-input -F 'rename workspace to "%s"' -P 'Rename workspace: '
# dmenu_run
# rofi -show run
rofi -show drun -modi drun # drun is DesktopFile run option
