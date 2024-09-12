#!/bin/bash

TPM_DIR="$HOME/.tmux/plugins/tpm"


if [ -d "$TPM_DIR" ]; then
    echo "Existing TPM directory found. Removing it..."
    rm -rf "$TPM_DIR"
fi

mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $TPM_DIR

# Install plugins using command(C-I) on Tmux
# And Reload Plugins using command(C-r) on Tmux
# https://github.com/tmux-plugins/tpm
