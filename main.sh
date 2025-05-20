#!/bin/bash

# List disks
sudo fdisk -l

# Prompt for device
read -rp "Enter the name of the drive (e.g., /dev/sdb): " usb

# Check if device exists
if [ ! -b "$usb" ]; then
    echo "Device $usb not found!"
    exit 1
fi

echo "WARNING: This will erase all data on $usb. Continue? (y/n)"
read -r confirm
if [[ "$confirm" != "y" ]]; then
    echo "Aborted."
    exit 1
fi

# Unmount all partitions
sudo umount "${usb}"* 2>/dev/null

# Partition the drive
echo -e "o\nn\np\n1\n\n+512M\nt\nc\nn\np\n2\n\n\nw" | sudo fdisk "$usb"

# Wait for kernel to recognize new partitions
sleep 2

# Format partitions
sudo mkfs.vfat -F32 -n BOOT "${usb}1"
sudo mkfs.ext4 -L persistence "${usb}2"

# Mount persistence partition
sudo mkdir -p /mnt/my_usb
sudo mount "${usb}2" /mnt/my_usb

# Create persistence.conf
echo "/ union" | sudo tee /mnt/my_usb/persistence.conf

# Unmount
sudo umount /mnt/my_usb

echo "Done."
exit