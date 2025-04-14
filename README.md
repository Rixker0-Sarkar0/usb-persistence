# USB Persistence Setup Script

This script automates the creation of persistence on a USB drive containing a live Linux system.

## 🔧 Prerequisites

- **Root privileges**: Run the script with `sudo`.
- **USB drive identification**: Use `sudo fdisk -l` to identify the device (look for the one matching your drive's size).
- **A prepared USB drive**: Ensure the USB drive has a live ISO already written to it.

## 🚀 What the Script Does

1. **Partitioning**:  
   - Creates a **512MB** partition for persistence.
   - Allocates the remaining space for ISO storage.

2. **Formatting**:  
   - Formats both partitions as `ext4`.
   - Labels the partitions as `persistence` (for persistence) and `iso` (for the ISO storage).

3. **Setup Persistence**:  
   - Mounts the persistence partition.
   - Creates a `persistence.conf` file with the configuration line `/ union` to enable persistence.
   - Unmounts the partition after setup.

## ⚠️ Disclaimer

- This script is **minimal** and **unmaintained**.
- No further debugging, updates, or features are planned.
- **Use at your own risk**: The author is not responsible for any data loss or hardware issues.
