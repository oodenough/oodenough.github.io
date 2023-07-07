---
categories: 2023 04
tags: [linux]
pin: false
---

* just some linux commands
```bash
du -h / | sort -rh | head -n 10
dpkg --print-architecture #==> check the cpu architecture
arch
[ -d /sys/firmware/efi ] && echo "UEFI mode" || echo "BIOS mode"
ssh-keygen -p -f ~/.ssh/id_rsa #==> reset the pathphrase for rsa keys
sudo dpkg-reconfigure console-setup #==> set the font for tty
cat /etc/passwd | grep -v nologin #==> validate users
```

## Disk/Partitions
* list disks/devices/partitions
1. `fdisk -l`
2. `lsblk` 

* modify
3. `cfdisk /dev/sda`
4. `gdisk /dev/sda`

* check/modify bulk information
5. `e2label /dev/sda1 labelname`
6. `blkid`
7. `df -h`

## Files
* check file/directory volume
1. `ls -lh `
2. `du -h`