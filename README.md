# USB Persistence Setup Script

This repository provides scripts to automate the creation of persistence on a USB drive containing a live Linux system. Both Linux (`main.sh`) and Windows (`win.ps1`) scripts are included.

## 🔧 Prerequisites

- **Root/Administrator privileges**:  
  - On Linux, run the script with `sudo`.
  - On Windows, run PowerShell as Administrator.
- **USB drive identification**:  
  - On Linux, use `sudo fdisk -l` to identify the device (look for the one matching your drive's size).
  - On Windows, open PowerShell as Administrator and use the `Get-Disk` command to list all connected drives. Look for the USB drive based on its size and other identifying details. For more information, refer to the [Microsoft documentation on Get-Disk](https://learn.microsoft.com/en-us/powershell/module/storage/get-disk).
- **A prepared USB drive**:  
  - Ensure the USB drive has a live ISO already written to it (if needed).

## 🚀 What the Scripts Do

### Linux ([main.sh](main.sh))

1. **Partitioning**:  
   - Creates a **512MB** FAT32 partition labeled `BOOT`.
   - Allocates the remaining space for an `ext4` partition labeled `persistence`.

2. **Formatting**:  
   - Formats the first partition as `FAT32` (`BOOT`).
   - Formats the second partition as `ext4` (`persistence`).

3. **Setup Persistence**:  
   - Mounts the persistence partition.
   - Creates a `persistence.conf` file with the configuration line `/ union` to enable persistence.
   - Unmounts the partition after setup.

### Windows ([win.ps1](win.ps1))

1. **Partitioning**:  
   - Creates a **512MB** FAT32 partition labeled `BOOT`.
   - Allocates the remaining space for an `NTFS` partition labeled `persistence`.

2. **Formatting**:  
   - Formats the first partition as `FAT32` (`BOOT`).
   - Formats the second partition as `NTFS` (`persistence`).

3. **Setup Persistence**:  
   - Creates a `persistence.conf` file with the configuration line `/ union` on the `persistence` partition.

## ⚠️ Disclaimer

- These scripts are **minimal** and **unmaintained**.
- No further debugging, updates, or features are planned.
- **Use at your own risk**: The author is not responsible for any data loss or hardware issues.