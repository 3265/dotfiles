#!/bin/bash

set -e

sudo tee /etc/sysctl.d/99-inotify.conf > /dev/null <<'EOF'
fs.inotify.max_user_instances=1024
EOF

sudo sysctl -p /etc/sysctl.d/99-inotify.conf
