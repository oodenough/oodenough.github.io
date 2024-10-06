---
title: Windows 修复 EFI 分区 
image:
  path: ./assets/img/2023/windows11.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Windows 11
---

**EFI分区**里有 `bootmanager` 和 `bootloader`

装有多个操作系统的电脑开机时，首先进入**bootmanager**界面，选择加载哪个**bootloader**，然后**bootloader**再 `boot` 对应系统。

## 创建 EFI 分区

如果只是分区里的文件损坏，efi分区还在的话可以跳过这一步。

Windows 无法自己创建EFI分区，要借助第三方工具。

我使用的是 Arch Linux 的 LiveOS，烧录到U盘插电脑boot后进行操作。

分出适当的空间后，创建文件系统即可

```bash
mkfs.fat -F32 /dev/sda3
```

## 复制文件

有了EFI分区后，将合适的文件复制粘贴过去就完成修复了。

下载对应 Windows 的**iso**文件，烧录到U盘里。

然后插电脑**boot**，选择命令行修复操作系统。

运行`diskpart`工具

```bash
diskpart
```

列出硬盘

```bash
list disk
```

选择对应硬盘

```bash
sel disk 0
```

列出分区

```bash
list volume
```

在列出的几个分区中根据`FAT32`文件系统找到efi分区

选择efi分区

```bash
sel volume 2
```

分配盘符

```bash
assign letter K:
```

退出diskpart

```bash
exit
```

切换到EFI分区目录

```bash
cd /d K:
```

复制`bcd bootloader`的配置文件到当前目录

```bash
%WINDIR%\System32\Config\BCD-Template
```

修改文件属性

```bash
attrib BCD -s -h -r
```

重命名文件

```bash
ren BCD BCD.bak
```

复制 `UEFI` 所需要的文件

```bash
bcdboot C:\Windows /l en-us /s k: /f ALL
```

到此结束，重启后电脑就正常boot了。

[参考链接](https://woshub.com/how-to-repair-uefi-bootloader-in-windows-8/)
