# ⚡ Hacktiva1si0n v1.2.0
> **Automated A5/A6 Legacy iOS Local Hacktivation Orchestrator** > Developed by **RetroHackLab** (2026) — *"I Love Memory"*

---

## ⚠️ Important Notice & Disclaimer
**EDUCATIONAL AND RESEARCH PURPOSES ONLY.** This project is shared purely as a technical study of legacy iOS system architecture, file system permissions, and hardware constraints (`lockdownd` subroutines). RetroHackLab does not condone or support the bypassing of modern device security. Use this tool only on legacy hardware you owned or have explicit permission to test.

---

## 🚀 Features
* **Convert to Activated:** Hardware-level patch by swapping the native `usr/libexec/lockdownd` server on your mounted partition to bypass the Apple SIM/Activation check permanently.
* **Fix Syncing:** Restores complete iTunes synchronization functionality by simulating a structural activation ticket state.
* **Fix App Installer:** Grants normal operations for native applications and IPA deployment profiles across legacy architectures.
* **❌ Exception - Signal Fix:** This is a **Local Hacktivation Bypass** via SSH Ramdisk. It does **NOT** generate official wildcard activation tokens from Apple's servers. Cellular signals, SMS, and carrier data are **NOT fixed** by this utility.

---

## 🛠️ System Requirements
* **Host Environment:** Linux (Ubuntu 22.04 LTS / WSL2 preferred) with `git`, `ssh`, `scp`, and `sshpass` installed.
* **Hardware Target:** Apple A5 or A6 SoC devices (`iPhone 4S`, `iPhone 5`, `iPhone 5c`, `iPad 2/3/4`, `iPad Mini 1`, `iPod Touch 5`).
* **Firmware Support:** Strictly checked for **iOS 5.0 up to iOS 6.1.6** (Any other system triggers an `[Unsupported]` block).
* **Prerequisite:** Device must **already be connected** via an established SSH Ramdisk bridge (e.g., via Legacy iOS Kit) mapping communication to `127.0.0.1` on Port `6414`.

---

## 📖 How To Use

1. **Establish the SSH Ramdisk Link** Use your hardware toolchain [like an Arduino Uno USB Host Shield Checkm8  for A5](https://github.com/LukeZGD/checkm8-a5) or Require [Gaster](https://github.com/vvaske/gaster-win-mac)  via [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) to boot your target device into an SSH Ramdisk state. Ensure it is actively listening on port `6414`.

2. **Execute the Suite** Open your Linux console/Mac Console and run the main orchestrator script:
   ```bash
   chmod +x *.sh
   ./ramdisk.sh
