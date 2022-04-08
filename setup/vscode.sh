#!/bin/zsh

pkglist=(
    vscodevim.vim
    ms-vscode-remote.remote-ssh
    ms-vscode.cpptools
    ms-vscode.typescript-javascript-grammar
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.jupyter
    ms-azuretools.vscode-docker
    alefragnani.Bookmarks
    Gruntfuggly.todo-tree
    dinhani.copy-on-select
    christian-kohler.path-intellisense
    nowsci.glassit-linux
    esbenp.prettier-vscode
    njpwerner.autodocstring
    mechatroner.rainbow-csv
)


pkglist_django=(
    batisteo.vscode-django
    mrorz.language-gettext
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done

