#!/bin/bash

curl -sSL https://install.python-poetry.org | python3 -

# for poetry shell
poetry self add poetry-plugin-shell
