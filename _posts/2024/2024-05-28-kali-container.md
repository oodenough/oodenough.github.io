---
title: kali容器的基本使用
categories: [OS, mac]
tags: [docker, kali]
pin: false
---

分享如何优雅地在mac上通过容器使用kali。

## 安装docker

docker依赖于linux内核，windows有WSL，mac则选择[colima](https://github.com/abiosoft/colima)。

简单说colima就是通过一台linux虚拟机从而为docker提供runtime.

## 启动kali容器

根据[官方文档](https://www.kali.org/docs/containers/using-kali-docker-images/),在mac上使用kali容器只需要两步。

首先下载镜像`docker pull docker.io/kalilinux/kali-rolling`, 然后启动容器即可`docker run --tty --interactive kalilinux/kali-rolling`.

## 修改/保存kali

容器退出后还可以重启，里头文件还在，但是如果容器被删除, 那么文件就全丢失了。

所以在对容器作出修改后不妨创建一个新的镜像加以保存。

`docker commit 33e5d2bda400 mykali`

第一个参数是容器id，然后是新image的名称。

如何重命名image可以参考[stackoverflow](https://stackoverflow.com/questions/25211198/docker-how-to-change-repository-name-or-rename-image).

## 与host共享文件

在第一次容器时(docker run)，可以通过`-v`选项来把host的目录挂载到容器。

所以，如果容器已经启动，为了数据不丢失，可以先保存新的镜像再来重新启动容器，一并挂载新目录。

`docker run --tty --interactive --name kali -v /Users/saul/kali/:/mac mykali`

* `--name`显然是给容器命名，以后可以用名字来替代id。
* `-v`后第一个是目录在host的路径，冒号后则是容器内挂载路径。
* `mykali` 是使用的镜像。

## proxy

同样是在容器启动时设定。

加一个`-e HTTP_PROXY=http://username:password@proxy2.domain.com`选项即可。

还可以修改`~/.docker/config.json`配置文件，这样容器启动就默认使用代理。

注意`localhost`在容器里要用`host.docker.internal`替代. [link](https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach)

更多内容请参考[官方文档](https://docs.docker.com/network/proxy/)或[stackoverflow](https://stackoverflow.com/questions/47827496/how-to-configure-docker-container-proxy)

## 结语

目前为止我的使用需要止步于此, 无非修改保存、共享文件、开代理三个操作。

以后有用到新的东西再分享。
