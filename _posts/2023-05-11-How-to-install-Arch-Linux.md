---
categories: w default
tags: [linux, archlinux]
---

## check the internet
```bash
iwctl #==> enter a iwd interactive prompt
device list #==> list available internet device
station wlan0 scan #==> tell the wlan0 to scan network
station wlan0 get-networks #==> list networks
station wlan0 connect wifiname #==> connect/passwords may be needed
exit #==> exit the interactive prompt/ 
ping google.com #==> test
vim /etc/pacman.d/mirrorlist #==> edit the resource file

Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.dgut.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.nju.edu.cn/archlinux/$repo/os/$arch
Server = https://mirror.redrock.team/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch

timedatectl set-ntp true
```

## patition your disk
```bash
lsblk #==> list thd available disk and its patitions
fdisk -l #==> save as above but provide more information
gdisk /dev/sda #==> pacman -S gptdisk
fdisk /dev/sda #==> command line mode
cfdisk /dev/sda #==> easy to use
```
`swap` is optional
`EFI` is needed by UEFI 

file system:
```bash
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mkfs.fat -F32 /dev/sda3
```
mount:
```bash
swapon /dev/sdaa
mount /dev/sda2 /mnt/boot/efi
#==> mount device in a deeper directory first
mount /dev/sda3 /mnt
```

## download your system
keyring:
```bash
pacman -Sy archlinux-keyring
```
system parts:
```bash
pacstrap /mnt base linux linux-firmware vim
```
file system table:
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## chroot to add configuration
```bash
arch-chroot /mnt #==> chroot to new system
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime #==> timezone settings
hwclock --systohc #==> hardware clock
vim /etc/locale.gen #==> language settings
locale-gen #==> start/enable the language settings
echo LANG=en_US.UTF-8 >> /etc/locale.conf #==> environment variable LANG
echo abcd >> /etc/hostname #==> hostname
vim etc/hosts #==> edit hosts file as below

127.0.0.1	localhost
::1		    localhost
127.0.0.1	abcd.localdomain	abcd

passwd #==> password for root
```

## download more softwares 
```bash
pacman -S grub networkmanager network-manager-applet base-devel linux-headers 
#==> package: efibootmgr is needed for UEFI
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```
installation is done by now,
```bash
exit #==> exit chroot
reboot #==> remove the U disk
```

## initial tips
```bash
systemctl start NetworkManager
systemctl enable NetworkManager
nmtui
useradd -m -G wheel dfg
passwd dfg
EDITOR=vim visudo #==> or simple visudo

Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL:ALL) ALL

pacman -S xf86-video-intel
pacman -S xf86-video-amdgpu
pacman -S nvidia nvidia-utils
```

