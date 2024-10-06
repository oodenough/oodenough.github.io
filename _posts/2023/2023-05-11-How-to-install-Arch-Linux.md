---
title: 如何安装 Arch Linux
image:
  path: ./assets/img/2023/arch-logo.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Arch Linux
---

## 联网

进入 `iwd` 的交互式提示符

```bash
iwctl
```

列出可用的网络设备

```bash
device list
```

使用无线网卡 `wlan0` 扫描可用**wlan**

```bash
station wlan0 scan 
```

列出扫描到的**wlan**网络

```bash
station wlan0 get-networks
```

连接**wlan**网络

```bash
station wlan0 connect wifiname 
```

退出 `iwd` 提示符

```bash
exit
```

测试网络连接

```bash
ping baidu.com
```

更换软件源

```bash
vim /etc/pacman.d/mirrorlist
```

一些国内高校的软件源

```bash
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.dgut.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.nju.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch
```

通过网络同步日期和时间

```bash
timedatectl set-ntp true
```

## 分盘

列出可用存储

```bash
lsblk
```

或者用下面这条命令

```bash
fdisk -l
```

特别注意其中的**磁盘标签类型**，英文 `disk label tepy` ，BIOS 安装得是 `dos`，UEFI 得是 `gpt`

如果不对，可以下载 **gptdisk** 格式化磁盘后设置磁盘标签类型

```bash
gdisk /dev/sda #==> pacman -S gptdisk
```

对 `sda` 分盘

```bash
fdisk /dev/sda
```

或者

```bash
cfdisk /dev/sda
```

**关于如何分盘**:

> BIOS 电脑：

BIOS电脑不需要 `efi分区`，可以这么分：

* 1个：只分根分区 `/`

* 2个：`/` 和 `swap分区` **OR** `/` 和 `/home`

如果电脑的内存足够，**swap分区**就没必要了，因为它只是在电脑内存不够时救急用的。

* 更多：比如放**系统日志**的 `var` 分区和放**临时文件**的 `tmp` 分区各自再分一个。

> UEFI 电脑：

UEFI电脑额外需要一个 `efi分区` ，其他的都同 BIOS 一样。

**关于文件系统**:

为 `swap分区` 创建文件系统

```bash
mkswap /dev/sda2
```

为 `efi分区` 创建文件系统

```bash
mkfs.fat -F32 /dev/sda3
```

为 `/`、`var`、`tmp` 创建文件系统

```bash
mkfs.ext4 /dev/sda1
```

> sda1、sda2 是 `盘符`，注意区分
{: .prompt-info }

接下来开始 `挂载` 各个分区

若有swap先启用swap分区，挂载`顺序`从外往里，没有的目录手动创建。

```bash
swapon /dev/sda1 
mount /dev/sda3 /mnt #==> 根分区挂 /mnt
mount /dev/sda2 /mnt/boot/efi
```

## 下载系统组件

安装 keyring

```bash
pacman -Sy archlinux-keyring
```

安装 arch linux 系统

```bash
pacstrap /mnt base linux linux-firmware vim networkmanager network-manager-applet base-devel linux-headers efibootmgr 
```

BIOS 安装不需要 **efibootmgr** 

将文件系统的分区表写入新系统

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## chroot并配置新系统

chroot

```bash
arch-chroot /mnt
```

设置时区

```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

设置硬件钟

```bash
hwclock --systohc
```

设置语言并启用

```bash
vim /etc/locale.gen
locale-gen 
```

设置环境变量 **LANG**

```bash
echo LANG=en_US.UTF-8 >> /etc/locale.conf
```

设置hostname为abcd

```bash
echo abcd >> /etc/hostname
```

编辑 hosts 文件

```bash
vim etc/hosts
```

编辑成下面这个样子

```bash
127.0.0.1	localhost
::1		    localhost
127.0.0.1	abcd.localdomain	abcd
```

设置 **root** 密码

```bash
passwd #==> password for root
```

## 安装bootloader

安装 grub

```bash
pacman -S grub 
```

安装bootloader

```bash
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

到此安装结束，退出 `chroot`

```bash
exit
```

重启系统，拿走U盘

```bash
reboot 
```

## 开机后

启动网络服务

```bash
systemctl start NetworkManager
systemctl enable NetworkManager
```

开始联网

```bash
nmtui
```

添加用户 以用户名dfg为例

```bash
useradd -m -G wheel dfg
```

设置用户密码

```bash
passwd dfg
```

接下来为用户添加 `sudo` 权限

在 Arch Linux 中就是将用户添加到 `wheel` 组里。

用 vim 打开 visudo 文件

```bash
EDITOR=vim visudo
```

找到

```bash
# %wheel ALL=(ALL:ALL) ALL
```

把前面的 `#` 注释掉就可以保存退出了
