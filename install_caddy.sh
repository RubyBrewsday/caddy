#!/bin/bash

# URL to the caddy script
CADDY_URL="https://raw.githubusercontent.com/RubyBrewsday/caddy/main/caddy"

# Directory to install the script
INSTALL_DIR="/usr/local/bin"

# Check if yq is installed
if ! command -v yq &> /dev/null
then
    echo "yq could not be found, installing yq..."
    if command -v brew &> /dev/null; then
        brew install yq
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install yq
    else
        echo "Package manager not found. Please install yq manually."
        exit 1
    fi
fi

# Download the caddy script
curl -o caddy $CADDY_URL

# Make the script executable
chmod +x caddy

# Move the script to the install directory
sudo mv caddy $INSTALL_DIR

# Verify installation
if command -v caddy &> /dev/null
then
    echo "caddy has been installed successfully!"
else
    echo "Installation failed. Please check the steps and try again."
    exit 1
fi
