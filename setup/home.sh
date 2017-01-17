#!/bin/bash

# home directory settign
mkdir -p ~/.config/peco
mkdir -p ~/.git_template/hooks

cp ~/dotfiles/sh/prepare-commit-msg ~/.git_template/hooks/
chmod +x ~/.git_template/hooks/prepare-commit-msg
