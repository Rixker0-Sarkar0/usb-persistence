#!/bin/bash
fdisk -l
echo enter name storage of drive
read usb
fdisk $usb <<< $(printf "n\np\n\n\n\nw")
mkfs.ext4 -L persistence ${usb}3
mkdir -p /mnt/my_usb
mount ${usb}3 /mnt/my_usb
echo "/ union" | sudo tee /mnt/my_usb/persistence.conf
umount ${usb}3
exit
