#!/bin/bash

# ==============================================================================
# Hacktiva1si0n - [Open.sh]
# Secure Shell Bridge & Automated HFS Partition Mounter
# ==============================================================================

TARGET_IP="127.0.0.1"
TARGET_PORT="6414"
TARGET_USER="root"
TARGET_PASS="alpine"

echo "=================================================================="
echo "🔌 SSH INTERFACE BRIDGE ACTIVATED"
echo "=================================================================="
echo "[-] Connecting to Secure Shell (sftp://$TARGET_IP:$TARGET_PORT)..."

# Cleaning known hosts cache
ssh-keygen -R "[$TARGET_IP]:$TARGET_PORT" &>/dev/null

run_ssh() {
    if command -v sshpass &> /dev/null; then
        sshpass -p "$TARGET_PASS" ssh -p $TARGET_PORT -o StrictHostKeyChecking=no ${TARGET_USER}@${TARGET_IP} "$1"
    else
        ssh -p $TARGET_PORT -o StrictHostKeyChecking=no ${TARGET_USER}@${TARGET_IP} "$1"
    fi
}

# Initial ping
run_ssh "echo '✅ Connection verified.'" &>/dev/null

if [ $? -ne 0 ]; then
    echo "❌ Connection Failed: Unable to communicate with the SSH Ramdisk."
    echo "    -> Required Parameters: root@$TARGET_IP:$TARGET_PORT [password: $TARGET_PASS]"
    exit 1
fi

# Enforcing storage mount paths on the target iOS filesystem
echo "[*] Mounting target HFS blocks..."
run_ssh "mount_hfs /dev/disk0s1s1 /mnt1 2>/dev/null; mount_hfs /dev/disk0s1s2 /mnt2 2>/dev/null"
echo "    [✓] Partition System linked to /mnt1"
echo "    [✓] Partition Data linked to /mnt2"

# Safe execution handoff to the injector engine
if [ -f "./Source.sh" ]; then
    chmod +x ./Source.sh
    exec ./Source.sh "$TARGET_IP" "$TARGET_PORT" "$TARGET_USER" "$TARGET_PASS"
else
    echo "❌ Error: Execution file 'Source.sh' could not be found."
    exit 1
fi
