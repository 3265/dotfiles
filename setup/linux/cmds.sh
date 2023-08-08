#!/bin/bash

# pipx install poetry # => use poetry.sh
pipx install pipenv
pipx install pip-tools

pipx install black
pipx install isort
pipx install mypy
pipx install flake8
pipx install autoflake
pipx install pytest
pipx install Fabric3
pipx install ipython
pipx install ipdb

# pipx install codemod
cargo install fastmod

pipx install pycowsay

go install github.com/x-motemen/ghq@latest

cargo install mdbook
cargo install mdbook-pagetoc
cargo install fastmod
