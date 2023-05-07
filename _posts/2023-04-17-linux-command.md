---
categories: w default
tags: [linux]
---

* sexy
```bash
dpkg --print-architecture #==> check the cpu architecture
[ -d /sys/firmware/efi ] && echo "UEFI mode" || echo "BIOS mode"
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


