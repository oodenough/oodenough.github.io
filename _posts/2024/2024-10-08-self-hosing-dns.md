---
title: 用Docker自建DNS服务器
pin: false
---

我参考了[这篇博客](https://ghostdev.xyz/posts/self-hosting-dns)

## 初始设置

下面是`docker-compose.yml`的内容：

```bash
version: '3'

services:
    adguard-home:
        restart: always
        image: adguard/adguardhome
        volumes:
            - ./workdir:/opt/adguardhome/work
            - ./conf:/opt/adguardhome/conf
            # Required if you want DoH/DoT/DoQ - see section of this post about SSL
            - ./certs:/certs
        ports:
            # Plain DNS
            - '53:53/tcp'
            - '53:53/udp'
            # DOT
            - '853:853/tcp'
            # DOQ
            - '853:853/udp'
            # Admin UI
            - '80:80'
            - '443:443'
            # Initial setup (can be removed after first install)
            - '127.0.0.1:3000:3000'
        networks:
            - adguard_net

networks:
    adguard_net:
        driver: bridge
        ipam:
            driver: default
            config:
                - subnet: 172.28.0.0/16
```

建好相应的目录结构后用`docker compose up -d`命令启动容器，首先去3000端口完成initial setup.

可以用`ssh -L 8000:localhost:3000 -C -N -l root ip_addr`命令将本地的8000端口转发到服务器的3000端口，然后打开浏览器访问`localhost:8000`完成设置。

然后就可以注释掉`- '127.0.0.1:3000:3000'` 这一行，最后重启容器。

## 设置上游dns

剩下的设置可以访问web界面完成，也可以编辑`conf/AdGuardHome.yaml`完成。我感觉用gui更简单，比如设置证书的时候，填完证书路径就会提示该证书是否有效等等。

证书后面说，咱们先在HTTP页面完成上游dns服务器的设置，然后测试下能不能用。

推荐用cloudflare的服务器，因为cloudflare在[这篇博客](https://blog.cloudflare.com/announcing-the-results-of-the-1-1-1-1-public-dns-resolver-privacy-examination/)里声称**与第三方审计公司合作，以证明他们不会存储长期日志** ，[这里](https://www.cloudflare.com/resources/assets/slt3lc6tev37/5xlHCvvNBrvrIoWbuk1vTy/e1058b0d366adf4e983aef99a6ed2a1f/Cloudflare_1.1.1.1_Public_Resolver_Report_-_03302020__2_.pdf)是相关的审计报告。

![](https://i.imgur.com/pjdJXF3.png)

## 测试

打开终端，用`nslookup google.com ip_addr`命令测试一下你的dns服务器有没有在工作，把`ip_addr`换成你的服务器地址。

如果返回`;; connection timed out; no servers could be reached`，别忘了打开你的53端口，`TCP`和`UDP`都打开。

## 效果如何

之前：

![](https://i.imgur.com/paRgaln.png)

之后：

![](https://i.imgur.com/rePHfPe.png)

截图来自<https://dnschecck.tools>

## 添加证书

证书可以**self-signed**，参考的博客里用了[Let's Encrypt/ACME client](https://github.com/go-acme/lego?tab=readme-ov-file).

相关配置我都放[这个仓库](https://github.com/oodenough/lego-acme)里了，不过你需要一个域名，并且使用cloudflare的服务。首先`.env`里改一下环境变量，一个cloudflare的api token，一个邮件地址。然后再改一下`docker-compose.yml`里的域名，最后执行`crt.sh`脚本就可以生成证书了。

记得把证书文件放到相应位置，重启容器后在web界面设置证书路径和服务器名称等等相关信息。

设置后刷新一下应该就是HTTPS的web界面了。

## 加密dns

53端口用于普通的dns，即**plain dns**，这是没加密的。

请求的网址和返回的ip都是明文，见下图：

![](https://i.imgur.com/r2ayda5.png)

不过能用上自建的dns服务器已经是一大进步了，加密dns改日再折通吧。

![](https://i.imgur.com/NUDlWLR.png)
