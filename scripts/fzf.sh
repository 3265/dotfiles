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
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --prompt="File>" ))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

#######################################
# Changing Directory
#######################################

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.git*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m --preview "tree -C {} -h -l 1" --prompt="Directory>" )
  cd "$dir"
}

#######################################
# Cmd history
#######################################

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --preview '' --prompt="History>"  | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

#######################################
# Processes
#######################################

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m --prompt="Process>" --preview ''  | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m --prompt="Process>" --preview ''  | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

#######################################
# Grep
#######################################

# fuzzy grep open via ag
fg() {
  local file
  file="$(ag --nobreak --noheading -l $@ | fzf --preview "ag $@"' {}' --prompt="Grep>" -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     $EDITOR $file
  fi
}

#######################################
# Git branch
#######################################

# ga/gd
# from https://github.com/EfforiaKnight/fizzygit

go() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m --prompt="Grep>" --preview="" ) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gh() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m --prompt="Grep>" --preview="" ) &&
  git push origin $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gu() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m --prompt="Grep>" --preview="" ) &&
  git pull origin $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gv() {
  local branches branch
  files=$(git status --short) &&
  file=$(echo "$files" |
           fzf -d $(( 2 + $(wc -l <<< "$files") )) +m --prompt="Grep>" --preview="" ) &&
  $EDITOR $(echo "$file" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
