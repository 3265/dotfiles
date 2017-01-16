# homebrew
export PATH=/usr/local:$PATH

#.bashrcの読み込み(for mac)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# source hilight用のless
source-hilight-less() {
  for fn in "$@"; do
    source-highlight -s bash --out-format=esc -o STDOUT -i $fn 2>/dev/null || /bin/less $fn;
  done
}

# ls color
ls-color() {
  path="."
  if [ -n "$1" ]; then path=$1; fi
  if [ "$(uname)" == 'Darwin' ]; then
    ls -alhF -G $path
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    ls -alhF --color=auto $path
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
}

xfunc() {
  RET=$(find . -type d | egrep -v '(.git|.go|node_modules|vender)' | peco)
  if [ -e "$RET"  ]; then
    cd $RET
  fi
}

yfunc() {
  RET=$(find . -type f | egrep -v '(.git|.go|node_modules|vender)' | peco)
  if [ -e "$RET"  ]; then
    vim $RET
  fi
}

zfunc() {
  RET=$(history | cut -c 8- | peco)
  if [ -e "$RET"  ]; then
    eval $RET
  fi
}

# Settings for GAE(MacDev)
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=~/.go
export PATH=$PATH:$HOME/go_appengine:$GOPATH/bin

# Setting for Docker
source ~/dotfiles/.dockerconfig

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/kanekotakeshi/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/kanekotakeshi/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/kanekotakeshi/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/kanekotakeshi/google-cloud-sdk/completion.bash.inc'
fi


