#!/bin/bash
# Python tools installation
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-poetry \
  python3-mypy \
  python3-pytest \
  python3-ipython \
  python3-flake8 
  #pgcli

python -m pip install -U "huggingface_hub[cli]" hf_xet black

