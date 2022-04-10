#!/bin/bash

# change docker effect
defaults write com.apple.dock mineffect suck
killall Dock

# show hidden files
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder

# change screenshot save directory
mkdir ScreenShot
defaults write com.apple.screencapture location ~/ScreenShot
killall SystemUIServer

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# For terminal
brew install the_silver_searcher
brew install htop
brew install wget
brew install ctags
brew install grc
brew cask install mosh
brew cask install sshfs
brew install gist

# VIM
brew install neovim/neovim/neovim
pip2 install --user neovim # Enable python2 on vim
# pip3 install --user neovim
# brew install macvim

# Finder in terminal
brew install ranger
brew install highlight
ranger --copy-config=all

# tmux
brew install tmux
brew install reattach-to-user-namespace # for copying in tmux
# for tmux 2.3
# wget https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
# tar xzvf tmux-2.3.tar.gz
# cd tmux-2.3
# ./configure && make
# sudo make install

# Git
brew cask install git
brew cask install tig
brew install fswatch

# C
brew install cppcheck
brew install clang-format

# Golang
brew install go
brew install peco
brew install direnv
brew cask install docker
brew cask install docker-machine
brew cask install virtualbox
# brew cask install the-unarchiver

# Desktop App

brew cask install chromium
brew cask install iterm2

# haskell
brew install ghc

# menu app
brew install caffeine
brew install clipmenu

brew update && brew upgrade go # for go 1.7

# ds file all removing cmd
# find ~/directory -name ".DS_Store" -print -exec rm {} ";"
# find ~/directory -name "._.DS_Store" -print -exec rm {} ";"

