---
categories: w default
tags: [virtualization, linux, archlinux]
---

* install virtual box 
`sudo apt-get install virtualbox`
* choose the efi mode in box
`settings => system => extended features => enable EFI`
* difference between BIOS
1. one more patition `efi` (500M is enough)
2. one more package `efibootmgr` (install using pacstrap command)
3. `gpt` disk label type for efi not the `dos` for BIOS
4. `efi` partition shoulb be `fat` filesystem (`/` is `ext4`)
`mkfs.fat -F32 /dev/sda1`
mount `efi` under `/mnt/boot/efi` 
`mkdir /mnt/boot/efi` then mount
* tips
both `cfdisk /dev/sda` and `fdisk /dev/sda` is available when patitioning
and `cfdisk` is easier to use
* virtual box use
1. enable shared clipb

