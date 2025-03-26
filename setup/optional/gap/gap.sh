 #!/bin/bash

 sudo apt-get install build-essential autoconf libtool libgmp-dev libreadline-dev zlib1g-dev

# Exit on error
set -e

# Define variables
GAP_VERSION="4.13.0"  # Update this to the latest version
GAP_URL="https://github.com/gap-system/gap/releases/download/v$GAP_VERSION/gap-$GAP_VERSION.tar.gz"
INSTALL_DIR="$HOME/gap"
BUILD_DIR="$INSTALL_DIR/build"

# Create installation directory
echo "Creating installation directory at $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Download and extract GAP
echo "Downloading GAP version $GAP_VERSION..."
wget "$GAP_URL" -O gap.tar.gz
echo "Extracting GAP..."
tar -xzf gap.tar.gz --strip-components=1
rm gap.tar.gz

# Configure and compile GAP
echo "Configuring and building GAP..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
"$INSTALL_DIR/configure"
make -j$(nproc)

echo "GAP installation completed successfully." 
# see ~/gap/build/gap
