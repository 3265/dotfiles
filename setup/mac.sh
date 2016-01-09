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


# ds file all removing cmd
# find ~/directory -name ".DS_Store" -print -exec rm {} ";"
# find ~/directory -name "._.DS_Store" -print -exec rm {} ";"

# App store
# dash 3, xcode, slack, nozbe, caffeine, kobito, the unarchiver, ms one note
# toggle, pocket, stick, safecast, 1pass, veertu, instagram, sunrise calendar

# Manual
# firefox developer edition, opera developer, transtype 4, amazon prime music, azure storage explorer
# macvim-kaoriiya https://github.com/splhack/macvim-kaoriya


