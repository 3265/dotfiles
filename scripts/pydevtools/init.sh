#!/bin/bash

poetry env use $(which python)
poetry shell
pre-commit install
pre-commit run --all-files
