---
title: 定制Gmail邮件域名并由服务器发送
pin: false
---

## Cloudflare加Gmail的SMTP设置

要想将Gmail的邮件域名设置成你的域名，需要使用Cloudflare的Email Routing功能。

所以如果你的域名解析商不是Cloudflare，那么你可能需要更换一下。

具体怎么配置, 可以参考这个[gist](https://gist.github.com/irazasyed/a5ca450f1b1b8a01e092b74866e9b2f1)。

如果你已经可以使用Gmail以自己的域名发送邮件，发送到你域名的邮件也会转发到你指定的邮件地址，那么这一步就算成功了。

## msmtp安装配置

接下来为服务器安装SMTP客户端`msmtp`。

```bash
apt update
apt install msmtp msmtp-mta
```

配置文件`~/.msmtprc`:

```txt
# Gmail SMTP 配置示例
account default
host smtp.gmail.com
port 587
auth on
user your-email@gmail.com
# Gmail的App密码
password your-app-password
from your-email@your-domain.com
tls on
tls_starttls on
logfile ~/.msmtp.log
```

修改文件权限`chmod 600 ~/.msmtprc`

测试一下：`echo "Test email content" | msmtp recipient@example.com`

## 邮件格式与附件

ssmtp只支持发送纯文本，也不支持附件。

要想发送html格式的邮件并添加附件可以使用另一个邮件客户端`mutt`。

`apt install mutt`

编辑配置文件`.muttrc`:

```txt
set from = "your-email@gmail.com"
set realname = "Your Name"
set smtp_url = "smtp://your-email@gmail.com@smtp.gmail.com:587/"
set smtp_pass = "your-app-password"
```

测试一下:

```bash
echo "<html><body><h1>This is a HTML email</h1><p>With an attachment.</p></body></html>" | mutt -e "set content_type=text/html" -s "Test Subject" -a /path/to/your/file.txt -- recipient@example.com
```
