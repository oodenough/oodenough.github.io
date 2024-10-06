---
title: Tor bridges in CLI
categories: [Tools]
tags: [Network, Linux, mac]
pin: false
---

[上一篇](https://oodenough.github.io/posts/How-to-use-tor-on-linux/)写了Tor的安装和基本配置, 这一篇简单记录如何给命令行的tor配置网桥。

示例用了apt来安装，mac用homebrew就行。

网桥配置参考了[这里](https://askubuntu.com/questions/1183145/how-can-i-configure-tor-with-bridge-and-privoxy-to-proxy-entire-system)

## 安装 obfs4proxy

从名字不难猜到只支持obfs4网桥

```bash
sudo apt install obfs4proxy
```

## 配置网桥

在 `torrc` 里添加：

```
UseBridges 1 
ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy 
Bridge obfs4 89.163.181.170:443 A0D27B876F1DD14A15C223F48BD9CD4A6BC4517E cert=nOm4+38yOIZ+91ux/vMUOZjUv6pocGtPkZ1QUXumE03Y8akJmrdCwXzxvQVqVPLMlwQrXA iat-mode=0
```

网桥可以去[官网](https://bridges.torproject.org)找，还可以用这个[telegram bot](https://t.me/getbridgesbot)获取。

可以多加几个网桥到 `torrc` 里，只配置一个的话日志里还会有警告信息。

## tor 日志

重启tor服务后可以用下面的命令查看日志：

```bash
journalctl -exft Tor
```

## 检查连接

```bash
╰─➤  torify curl https://check.torproject.org/api/ip
{"IsTor":true,"IP":"185.220.101.149"}#
```

## 如何使用

如[上一篇](https://oodenough.github.io/posts/How-to-use-tor-on-linux/)所讲可以用torify命令， 还可以用 `torsocks` 命令。

大概是这样：

```bash
╰─➤  . torsocks on
Tor mode activated. Every command will be torified for this shell.
```

```bash
╰─➤  . torsocks off
Tor mode deactivated. Command will NOT go through Tor anymore.
```

## 代理端口

tor: 9050
tor browser: 9150
