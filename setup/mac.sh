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

# brew
brew install the_silver_searcher
brew install htop
brew install go
brew install peco
brew install wget
brew install ctags
brew install caffeine
brew install clipmenu
brew install alfred
# brew install macvim
brew cask install chromium
brew cask install iterm2
brew cask install mosh
brew cask install sshfs
brew cask install git
brew cask install tig
brew cask install docker
brew cask install docker-machine
brew cask install virtualbox
brew cask install the-unarchiver

# for ranger
brew install ranger
brew install highlight
ranger --copy-config=all

brew install reattach-to-user-namespace # for copying in tmux
brew install cmatrix # for tmux screensavor


brew update && brew upgrade go # for go 1.7

# ds file all removing cmd
# find ~/directory -name ".DS_Store" -print -exec rm {} ";"
# find ~/directory -name "._.DS_Store" -print -exec rm {} ";"
