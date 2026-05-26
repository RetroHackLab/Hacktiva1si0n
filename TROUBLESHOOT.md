```markdown
# 🔍 TROUBLESHOOT.md — Hacktiva1si0n Diagnostic Guide

If your target A5/A6 device encounters deployment obstacles, review the standard legacy hardware bypass debugging steps below.

---

### 1. Script outputs `Status: [Unsupported]`
* **Cause:** The script read your mounted `SystemVersion.plist` and found a major build number outside the safe range (below `5.0` or above `6.1.6`), or your device processor returned an invalid string (e.g., an A7 device like the iPhone 5s).
* **Resolution:** Verify your IPSW build state. If the device was accidentally updated to iOS 7.x, you must downgrade it using your saved SHSH blobs or dual-boot methods before launching this script.

### 2. Connection Failed: Unable to reach the iDevice terminal
* **Cause:** `Open.sh` cannot ping port `6414` on your local host interface.
* **Resolution:** 1. Check if `iproxy` or your SSH forwarder tunnel closed unexpectedly.
    2. Confirm your configuration parameters inside `Open.sh` match the active ramdisk client framework port settings.
    3. Type `killall iproxy` on your host terminal and restart your toolchain map.

### 3. Device hangs on Black Screen or Boot Loop after injection
* **Cause:** Permissions mismatch on the file system root hierarchy. If `lockdownd` does not possess strict execution privileges, the iOS kernel refuses to run the daemon, causing a panic.
* **Resolution:** The tool runs a dual ownership adjustment block (`chown 0:0` then `chown root:wheel`). If it failed during transfer, check your storage partition spaces by running `df -h` inside a manual SSH connection to ensure `/mnt1` is not completely full.

### 4. No Carrier Signal / "No SIM Card Installed" Banner Is Missing
* **Cause:** This is an expected behavioral exception of a **Local Hacktivation Bypass**.
* **Resolution:** As outlined in the core specifications, cell service requires full official server ticket validation. Use this deployment specifically to reuse devices as test beds, storage sync clients, media players, or application design platforms.
