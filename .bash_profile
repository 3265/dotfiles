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

# Settings for GAE(MacDev)
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=~/.go
export PATH=$PATH:$HOME/go_appengine:$GOPATH/bin

# Setting for Docker
source ~/dotfiles/.dockerconfig
