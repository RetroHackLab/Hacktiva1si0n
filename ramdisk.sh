#!/bin/bash

# ==============================================================================
# Hacktiva1si0n - [ramdisk.sh]
# Main Orchestrator Pipeline
# ==============================================================================

clear
echo "=================================================================="
echo "          __====__                               "
echo "        _-        -_      HACKTIVA1SI0N ENGINE   "
echo "       /  O    O    \     [ MAIN MANAGEMENT ]    "
echo "      |    ____      |                           "
echo "       \  \____/    /     by RetroHackLab        "
echo "        _-________-_                             "
echo "=================================================================="

# STEP 1: Execute Git Dependency Installer
if [ -f "./Git.sh" ]; then
    echo "[-] Launching Git dependency setup..."
    chmod +x ./Git.sh
    ./Git.sh
    if [ $? -ne 0 ]; then
        echo "❌ Error: Git setup pipeline failed."
        exit 1
    fi
else
    echo "❌ Critical Error: 'Git.sh' is missing."
    exit 1
fi

# STEP 2: Execute SSH Connection and Mounting Interface
if [ -f "./Open.sh" ]; then
    echo "[-] Launching SSH connection interface..."
    chmod +x ./Open.sh
    ./Open.sh
else
    echo "❌ Critical Error: 'Open.sh' is missing."
    exit 1
fi
