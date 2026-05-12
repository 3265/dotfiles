#!/bin/bash
# Python tools installation
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-poetry \
  python3-black \
  python3-mypy \
  python3-pytest \
  python3-ipython \
  python3-flake8 \
  pgcli

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
