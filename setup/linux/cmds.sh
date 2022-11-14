#!/bin/bash

pipx install poetry
pipx install pipenv
pipx install pip-tools

pipx install black
pipx install isort
pipx install mypy
pipx install flake8
pipx install autoflake
pipx install pytest
pipx install Fabric3

# pipx install codemod
cargo install fastmod

pipx install pycowsay

go install github.com/x-motemen/ghq@latest
