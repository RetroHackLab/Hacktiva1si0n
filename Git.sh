#!/bin/bash

# ==============================================================================
# Hacktiva1si0n - [Git.sh]
# Git Repository Installer & Local Permission Provisioner
# ==============================================================================

echo "=================================================================="
echo "📦 DEPENDENCY DEPLOYMENT STAGE"
echo "=================================================================="

# Updating package lists and installing Git environment
echo "[-] Updating system packages and installing Git..."
sudo apt update && sudo apt install git -y

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to install Git via apt."
    exit 1
fi
echo "    [✓] Git package is successfully installed."

# Cloning the lockdownd target payload repository
echo "[-] Cloning legacy activation payload repository..."
if [ -d "iOS-5-6-Hacktivation" ]; then
    echo "    ℹ️ Existing repository detected. Refreshing source trees..."
    rm -rf iOS-5-6-Hacktivation
fi

git clone https://github.com/iPh0ne4s/iOS-5-6-Hacktivation

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to clone the repository."
    exit 1
fi
echo "    [✓] Repository downloaded successfully."

# Structuring explicit binary and folder access rights
echo "[-] Granting execution permissions to downloaded payloads..."
chmod 755 iOS-5-6-Hacktivation/lockdownd
chmod -R 755 iOS-5-6-Hacktivation/

echo "    [✓] Local file permissions successfully configured to 755."
echo "=================================================================="
echo ""
chmod+x Open.sh
./Ooen.sh
