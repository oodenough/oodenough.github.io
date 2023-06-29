---
categories: 2023 06
tags: [linux, tricks]
pin: false
---

## 简介

`tor`的全称是`the onion router`,是用来保护互联网隐私的一个开源软件。
这篇文章是在debian上安装使用tor代理的过程。



![alt text](C:\Users\27300\Documents\oodenough.github.io\assets\img\postimgs\tor.png)



> 使用tor的 `前提` 是能够连接到tor的节点(relay)
> {: .prompt-info }



![alt text](C:\Users\27300\Documents\oodenough.github.io\assets\img\postimgs\torrelay.png)



## 安装

在 `debian` 上安装 `tor` 只需要执行一条命令

```bash
sudo apt-get install tor
```

## 配置

编辑torrc文件

```bash
sudo vi /etc/torrc
```

找到并注释下面这行

```bash
#ControlPort 9051
```

再找到下面这行把 `1` 改成 `0` 

```bash
#CookieAuthentication 1
```

重启 `tor` 

```bash
sudo /etc/init.d/tor restart
```

## 测试

查看 `真实的公网ip` 

```bash
curl ifconfig.me
```

查看 `使用tor后的ip` 

```bash
torify curl ifconfig.me 2>/dev/null
```

对于这条命令：

* `torify` => 通过 `tor` 执行 `curl` 命令

* `2>/dev/null` => 重定向 `torify` 产生的无关信息

## 获取新ip

如果连接成功，上一步中将输出不同的 `ip` ，那么当前 `shell` 的网络流量就是经过 `tor circuit` 代理的。



如果想更换 `tor circuit` ，可以执行

```bash
echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
```

然后再根据 `测试` 中给出的步骤重新检查 `ip` 

## 为firefox浏览器开启tor

1. 编辑配置文件 `torrc` 找到并注释
   
   ```bash
   #SocksPort 9050
   ```

2. 在火狐浏览器中找到 `Network Settings` 开始手动设置:
* `SOCKS Host` 为 `127.0.0.1` 

* `Port` 为 `9050` 

* 使用 `SOCKS v5` 代理选项

* `No Proxy for` 为 `127.0.0.1` 

* 勾选 `Proxy DNS when using SOCKS v5` 
3. 测试
   
   点击访问 [tor测试站点](check.torproject.org) 

## nyx

`nyx` 在安装 tor 的时候默认一并安装，是一个与 tor 配合使用的流量监控界面 



![Alt Text](C:\Users\27300\Documents\oodenough.github.io\assets\img\postimgs\nyx.png)
