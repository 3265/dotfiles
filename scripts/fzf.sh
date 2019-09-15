#!/bin/bash

# NOTE:
# - i just copied these useful scripts from the site which shows fzf example below
# - and little bit modified them.
# https://github.com/junegunn/fzf/wiki/examples

#######################################
# Openning File
#######################################

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

#######################################
# Changing Directory
#######################################

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.git*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m --preview "tree -h -l 1 {}") &&
  cd "$dir"
}

#######################################
# Cmd history
#######################################

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --preview '' | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

#######################################
# Processes
#######################################

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}


# fuzzy grep open via ag
fg() {
  local file
  file="$(ag --nobreak --noheading -l $@ | fzf --preview "ag $@"' {}' -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     $EDITOR $file
  fi
}
