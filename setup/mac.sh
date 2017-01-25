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
brew install htop
brew install peco
brew install golang
brew install wget
brew install ctags
brew install caffeine
brew install clipmenu
brew install alfred
brew install macvim
brew cask install iterm2
brew cask install mosh
brew cask install sshfs
brew cask install git
brew cask install docker
brew cask install docker-machine
brew cask install virtualbox
brew cask install the-unarchiver
brew cask install chromium

# ds file all removing cmd
# find ~/directory -name ".DS_Store" -print -exec rm {} ";"
# find ~/directory -name "._.DS_Store" -print -exec rm {} ";"
