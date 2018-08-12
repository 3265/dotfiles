#!/sh/bash

git clone https://github.com/riywo/anyenv ~/.anyenv

anyenv install rbenv
anyenv install pyenv
anyenv install goenv
anyenv install jenv
anyenv install ndenv
exec $SHELL -l

anyenv version

# rbenv install 2.1.0
# pyenv install 2.7.6
# pyenv install 3.3.3
# goenv install 1.9.2
# jenv install oracle-1.7.0
# ndenv install v0.10.25

# rbenv global 2.1.0
# pyenv global 3.3.3
# ndenv global v0.10.25
# jenv global oracle-1.7.0
# goenv global 1.9.2
