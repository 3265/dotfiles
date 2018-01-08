# ------------------------------
# Autoload settings
# ------------------------------

autoload -Uz run-help
autoload -Uz add-zsh-hook             # hook関数をロード
autoload -Uz colors; colors           # カラーをロード
autoload -Uz compinit; compinit -u    # 補完を開始(さいつよ)
autoload predict-on; predict-on       # 予測有効(超有能)
autoload -Uz is-at-least              #
autoload zed                          # zedを使用する
autoload -Uz vcs_info                 # vcs_infoをロード
autoload history-search-end
autoload -U tetris; zle -N tetris
autoload -U compinit; compinit        # lsの色

# ------------------------------
# General Settings
# ------------------------------

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

# Editor
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

### Ls Color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS # ZLS_COLORSとは？
export CLICOLOR=true # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 補完候補に色を付ける

# Settings for golang
export GOPATH="$HOME"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# History
export HISTFILE=~/.zsh_history # History file
export HISTSIZE=10000          # History size in memory
export SAVEHIST=1000000        # The number of histsize
export LISTMAX=50              # The size of asking history

# 3秒以上コマンドに時間がかかったら詳細表示
export REPORTTIME=3

# ------------------------------
# Path settings
# ------------------------------

eval "$(direnv hook zsh)"

# Setting for Ruby Env to reload the another path.
eval "$(rbenv init -)"
