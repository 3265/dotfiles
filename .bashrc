# shell option
shopt -s dotglob # Filter Hidden Files

HISTSIZE=10000
HISTFILESIZE=10000

# nvm
if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi

# Reload command aliases
source ~/dotfiles/.export

# Reload command aliases
source ~/dotfiles/.aliases

# mac sshfs
# alias blogfs='sshfs blog: ~/mp/blog -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=blog'
# alias kaishafs='sshfs kaisha: ~/mp/kaisha -oauto_cache,reconnect,defer_permissions,negative_vncache,noappledouble,volname=kaisha'

