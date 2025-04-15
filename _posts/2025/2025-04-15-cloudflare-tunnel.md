---
title: Cloudflare Tunnel 内网穿透
pin: false
---

根据[官方文档](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/)有两种方法可以创建tunnel，不过使用命令行工具`cloudflared`要更方便。

## quick tunnel

quick tunnel不需要配置，cloudflare会自动生成临时的域名。运行下面命令为本地8000端口所运行的服务配置一条公网可访问的隧道。

```bash
cloudflared tunnel --url http://localhost:8000
```

在输出中可以看到临时域名:

```text
2025-04-15T08:08:50Z INF +--------------------------------------------------------------------------------------------+
2025-04-15T08:08:50Z INF |  Your quick Tunnel has been created! Visit it at (it may take some time to be reachable):  |
2025-04-15T08:08:50Z INF |  https://thought-toddler-appearance-formats.trycloudflare.com                              |
2025-04-15T08:08:50Z INF +--------------------------------------------------------------------------------------------+
```


## 登录

```bash
cloudflared login
```

跳转浏览器登录成功后在终端会有这样的输出：`2025-04-14T06:43:56Z INF You have successfully logged in.
If you wish to copy your credentials to a server, they have been saved to:
/Users/saul/.cloudflared/cert.pem`

## 创建tunnel

```bash
cloudflared tunnel create tunnel-name
```

该命令会在`~/.cloudflared/`下保存一个`tunnel-id.json`的credentials文件用于认证tunnel。

## 配置dns及域名

```bash
cloudflared tunnel route dns tunnel-name example.yourdomain.com
```

⚠️ 前提是你的域名已经托管在cloudflare。

## 配置tunnel

编辑`~/.cloudflared/config.yaml`，添加以下内容：

```yaml
tunnel: tunnel-name
credentials-file: ~/.cloudflared/tunnel-id.json  # 路径根据实际生成的文件填写

ingress:
  - hostname: example.yourdomain.com
    service: http://localhost:8000
  - service: http_status:404
```

## 启动tunnel

```bash
cloudflared tunnel run tunnel-name
```

访问<https://example.yourdomain.com>即可通过tunnel访问本地8000端口所运行的服务。

## 多个tunnel配置

可以在`~/.cloudflared`下建立多个配置文件，运行时用`--config`指定：

```bash
cloudflared tunnel --config ~/.cloudflared/another-tunnel.yml run another-tunnel
```
