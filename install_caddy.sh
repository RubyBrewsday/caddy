#!/bin/bash

# URL to the caddy script
CADDY_URL="https://raw.githubusercontent.com/yourusername/yourrepo/main/caddy"

# Directory to install the script
INSTALL_DIR="/usr/local/bin"

# Function to install yq on macOS
install_yq_mac() {
    if command -v brew &> /dev/null; then
        echo "Installing yq using Homebrew..."
        brew install yq
    else
        echo "Homebrew not found. Please install Homebrew and try again."
        exit 1
    fi
}

# Function to install yq on Linux
install_yq_linux() {
    if command -v apt-get &> /dev/null; then
        echo "Installing yq using apt-get..."
        sudo apt-get update && sudo apt-get install -y yq
    elif command -v yum &> /dev/null; then
        echo "Installing yq using yum..."
        sudo yum install -y epel-release && sudo yum install -y yq
    else
        echo "Package manager not found. Please install yq manually."
        exit 1
    fi
}

# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "yq could not be found, installing yq..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_yq_mac
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_yq_linux
    else
        echo "Unsupported OS. Please install yq manually."
        exit 1
    fi
else
    echo "yq is already installed."
fi

# Download the caddy script
curl -o caddy $CADDY_URL

# Make the script executable
chmod +x caddy

# Move the script to the install directory
sudo mv caddy $INSTALL_DIR

# Verify installation
if command -v caddy &> /dev/null; then
    echo "caddy has been installed successfully!"
else
    echo "Installation failed. Please check the steps and try again."
    exit 1
fi
