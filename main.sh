#!/bin/bash
fdisk -l
echo "Enter the name of the drive (e.g., /dev/sdb):"
read usb
echo -e "o\nn\np\n1\n\n+512M\nn\np\n2\n\n\nw" | fdisk "$usb"
mkfs.ext4 -L persistence "${usb}1"
mkfs.ext4 -L iso "${usb}2"
mkdir -p /mnt/my_usb
mount "${usb}1" /mnt/my_usb
echo "/ union" | sudo tee /mnt/my_usb/persistence.conf
umount "${usb}1"
exit
