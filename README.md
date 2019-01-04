# dotfiles  

## Installation

\# | cmd
---|---
1 | sudo apt install git make
2 | git clone https://github.com/mgoldchild/dotfiles
3 | cd dotfiles
4 | make host
5 | :call dein#update() in vim
6 | cat ~/.ssh/id_rsa.pub # copy to github
7 | git remote remove origin; git remote add origin git@github.com:mgoldchild/dotfiles.git
