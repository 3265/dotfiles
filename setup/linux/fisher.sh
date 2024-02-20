#!/bin/fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o ~/.config/fish/functions/fisher.fish
source ~/.config/fish/functions/fisher.fish && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
