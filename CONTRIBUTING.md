# 🤝 CONTRIBUTING.md — Hacktiva1si0n Engineering Guidelines

Thank you for looking into contributing to the **Hacktiva1si0n** project ecosystem. Help preserve the legacy iOS jailbreak golden era with clean, modular shell standards.

---

## 📜 Development Guidelines

### 1. Maintain Monolithic Design Segregation
Do not combine the scripts back into a single massive file unless explicitly requested for deployment revisions. 
* Keep connection logic tied inside `Open.sh`.
* Keep repo-cloning and permission provisioning inside `Git.sh`.
* Keep strict hardware/firmware gatekeeping checks isolated within `Source.sh`.

### 2. Absolute Path Rule for Ramdisk Execution
When scripting extensions for file modifications, never use native root layout syntax. Always prepend variables pointing to your mounted nodes:
* Use `$MNT_SYS` for operations targeting system file layouts (`/mnt1`).
* Use `$MNT_DATA` for user preferences and configuration tracking (`/mnt2`).

### 3. Error Handling Standards
Every file manipulation check or verification parameter update must end with an explicit validation tracking check. If a sub-process crashes, use clean termination rules:
```bash
if [ $? -ne 0 ]; then
    echo "❌ Error description here."
    exit 1
fi
