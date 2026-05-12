#!/bin/bash
# Master setup script

echo "Starting system setup..."

# 1. System/Env setup
# bash setup/sys/init.sh
# bash setup/sys/docker.sh

# 2. Base packages
bash setup/modules/base.sh

# 3. Development modules
bash setup/modules/shell.sh
bash setup/modules/editor.sh
bash setup/modules/terminal.sh
bash setup/modules/ai.sh
bash setup/modules/python.sh
bash setup/modules/blog.sh
bash setup/modules/languages.sh
bash setup/modules/cloud.sh

# 4. Apps
# for app in setup/apps/*.sh; do
#     bash "$app"
# done

echo "Setup complete."
