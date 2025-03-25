#!/bin/bash

# ref: https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt

#!/bin/bash

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide a name for the SSH key"
    echo "Usage: $0 <key-name>"
    exit 1
fi

KEY_NAME=$1

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh/
cd ~/.ssh/

# Generate SSH key
yes | ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_${KEY_NAME}_rsa


if [ $? -ne 0 ]; then
    echo "Error: Failed to generate SSH key"
    exit 1
fi

# Set proper permissions
sudo chmod -R 700 ~/.ssh/
sudo chmod 600 ~/.ssh/id_${KEY_NAME}_rsa

# Add config entry
cat >> config <<EOF
Host github.com
    HostName            github.com
    IdentityFile        ~/.ssh/id_${KEY_NAME}_rsa
EOF

# Display public key
cat ~/.ssh/id_${KEY_NAME}_rsa.pub

