#!/bin/bash

# ==============================================================================
# Hacktiva1si0n - [Source.sh]
# Architecture Audit, Payload Transfer & Security Permission Overrider
# ==============================================================================

TARGET_IP=$1
TARGET_PORT=$2
TARGET_USER=$3
TARGET_PASS=$4

MNT_SYS="/mnt1"
MNT_DATA="/mnt2"
LOCAL_PAYLOAD="./iOS-5-6-Hacktivation/lockdownd"

run_ssh() {
    if command -v sshpass &> /dev/null; then
        sshpass -p "$TARGET_PASS" ssh -p $TARGET_PORT -o StrictHostKeyChecking=no ${TARGET_USER}@${TARGET_IP} "$1"
    else
        ssh -p $TARGET_PORT -o StrictHostKeyChecking=no ${TARGET_USER}@${TARGET_IP} "$1"
    fi
}

echo "=================================================================="
echo "🎯 INJECTION CORE EXECUTION"
echo "=================================================================="

# 1. FIRMWARE RANGE CHECK
echo "[-] Verifying firmware target version..."
IOS_VERSION=$(run_ssh "cat $MNT_SYS/System/Library/CoreServices/SystemVersion.plist 2>/dev/null" | grep -A 1 "ProductVersion" | grep string | sed 's/.*<string>\(.*\)<\/string>.*/\1/')

if [ -z "$IOS_VERSION" ]; then
    echo "❌ Error: Cannot read iOS version string. Status: [Unsupported]"
    exit 1
fi
echo "    📱 System Version Detected: $IOS_VERSION"

IFS='.' read -r major minor patch <<< "$IOS_VERSION"
if (( major < 5 || major > 6 )); then
    echo "❌ Error: Selected iOS version is not supported! Status: [Unsupported]"
    run_ssh "umount $MNT_SYS 2>/dev/null; umount $MNT_DATA 2>/dev/null"
    exit 1
fi

# 2. SOC ARCHITECTURE CHECK
HW_MODEL=$(run_ssh "sysctl -n hw.machine 2>/dev/null")
echo "    🛠️  Hardware Chipset Identifier: $HW_MODEL"

case $HW_MODEL in
    iPhone4,1|iPhone5,1|iPhone5,2|iPhone5,3|iPhone5,4|\
    iPad2,1|iPad2,2|iPad2,3|iPad2,4|iPad2,5|iPad2,6|iPad2,7|\
    iPad3,1|iPad3,2|iPad3,3|iPad3,4|iPad3,5|iPad3,6|\
    iPod5,1)
        echo "    ✅ Silicon target hardware verified (Apple A5 / A6)."
        ;;
    *)
        echo "❌ Error: Chipset architecture mismatch! Status: [Unsupported]"
        run_ssh "umount $MNT_SYS 2>/dev/null; umount $MNT_DATA 2>/dev/null"
        exit 1
        ;;
esac

# 3. LOCKDOWND REPLACEMENT & PROTOCOLE DE DROITS
echo "[-] Deploying custom lockdownd activation bypass asset..."
if [ ! -f "$LOCAL_PAYLOAD" ]; then
    echo "❌ Error: Downloaded binary asset not found at $LOCAL_PAYLOAD !"
    exit 1
fi

# Backup native asset
run_ssh "mv $MNT_SYS/usr/libexec/lockdownd $MNT_SYS/usr/libexec/lockdownd.bak 2>/dev/null"

# Secure Copy payload transfer
if command -v sshpass &> /dev/null; then
    sshpass -p "$TARGET_PASS" scp -P $TARGET_PORT "$LOCAL_PAYLOAD" ${TARGET_USER}@${TARGET_IP}:$MNT_SYS/usr/libexec/lockdownd
else
    scp -P $TARGET_PORT "$LOCAL_PAYLOAD" ${TARGET_USER}@${TARGET_IP}:$MNT_SYS/usr/libexec/lockdownd
fi

# Applying mandatory Apple system ownership variables
echo "[*] Initializing system file ownership synchronization..."
run_ssh "chown 0:0 $MNT_SYS/usr/libexec/lockdownd"
run_ssh "chown root:wheel $MNT_SYS/usr/libexec/lockdownd"
run_ssh "chmod 755 $MNT_SYS/usr/libexec/lockdownd"
echo "    [✓] Ownership locked at root:wheel (755 permissions)."

# 4. SETUP APP LINK DEACTIVATION & PURPLEBUDDY KEYS INJECTION
echo "[-] Overriding Setup configuration keys..."
run_ssh "if [ -f $MNT_SYS/Applications/Setup.app/Setup ]; then mv $MNT_SYS/Applications/Setup.app/Setup $MNT_SYS/Applications/Setup.app/Setup.bak; ln -s $MNT_SYS/System/Library/CoreServices/SpringBoard.app/SpringBoard $MNT_SYS/Applications/Setup.app/Setup; fi"

run_ssh "mkdir -p $MNT_DATA/mobile/Library/Preferences"
run_ssh "cat <<EOF > $MNT_DATA/mobile/Library/Preferences/com.apple.purplebuddy.plist
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>SetupDone</key>
    <true/>
    <key>ActivationState</key>
    <string>Activated</string>
</dict>
</plist>
EOF"
run_ssh "chown 501:501 $MNT_DATA/mobile/Library/Preferences/com.apple.purplebuddy.plist; chmod 644 $MNT_DATA/mobile/Library/Preferences/com.apple.purplebuddy.plist"

# 5. SAFELY UNMOUNT AND INITIATE COLD REBOOT
echo "[-] Unmounting block nodes and requesting reboot sequence..."
run_ssh "sync; umount $MNT_SYS 2>/dev/null; umount $MNT_DATA 2>/dev/null"
run_ssh "reboot 2>/dev/null"

echo ""
echo "=================================================================="
echo "🎉 HACKTIVA1SI0N TARGET MODIFICATIONS APPLIED!"
echo "=================================================================="
echo " The device will boot bypass-complete shortly."
echo " RetrolHackLab Execution Complete."
echo "=================================================================="
