sudo apt install -y zsh
sudo apt install -y silversearcher-ag
sudo apt install -y tree
sudo apt install -y fzf
sudo apt install -y xsel # for copy command
sudo apt install -y autojump
sudo apt install -y exa
sudo apt install -y caffeine
sudo apt install -y direnv
sudo apt install -y cmake
sudo apt install -y screen
sudo apt install -y tmux
sudo apt install -y vim
sudo apt install -y emacs

# Pipenv
sudo apt-get -y install python3-pip python3-distutils python3-dev
sudo pip3 install --upgrade setuptools
sudo pip3 install pipenv

# Python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.6

# NOTE:
# - way to install fzf on jetson agx xavier.
# - go to the https://launchpad.net/ubuntu/+source/fzf
# - download arm binary. e.g. fzf_0.24.3-1_arm64.deb
# - install it by `sudo dpkg -i ~/Downloads/fzf_0.24.3-1_arm64.deb`

