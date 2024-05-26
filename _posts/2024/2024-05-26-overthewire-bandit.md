---
title: Overthewire Bandit 通关
categories: [OS, Linux]
tags: [Linux]
pin: false
---

[overthewire.org](https://overthewire.org/wargames/bandit/bandit6.html)网站[Bandit](https://overthewire.org/wargames/bandit/)游戏通关笔记。

包含各level的密码，以及通关思路，简单的就只给出一条命令和通关密码。

如果有错误，欢迎评论指出或者邮件联系。

# Bandit

## level 0 to 1 

NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL

## level 1 to 2 

rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi

`cat ./-`

## level 2 to 3 

aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG

`cat spaces\ in\ this\ filename`

## level 3 to 4 

2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe

`cat inhere/.hidden`

## level 4 to 5 

lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR

`file inhere/*`

## level 5 to 6 

P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU

`find inhere/ ##type f -print0 | xargs -0 ls -l | grep 1033`

## level 6 to 7 

z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S

`find / -user bandit7 -size 33c 2>/dev/null | xargs file`

## level 7 to 8 

TESKZC0XvTetK0S9xNwm25STk5iWrBvP

`grep millionth data.txt`

## level 8 to 9 

EN632PlfYiZbn3PhVK3XOGSlNInNE00t

`sort data.txt | uniq -u`

## level 9 to 10 

G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s

`strings data.txt | grep ===`

## level 10 to 11 

6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM

`base64 --decode -i data.txt`

## level 11 to 12 

JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv

`tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt`

## level 12 to 13 

wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw

`xxd -r data.txt data`

用`file`命令要更方便， 不用去查[list of file signatures](https://en.wikipedia.org/wiki/List_of_file_signatures)

文件经过多次压缩，所以逆完后重复 *改后缀，解压缩* 即可。

## level 13 to 14 

fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq

`ssh -p 2220 -i sshkey.private bandit14@localhost`

## level 14 to 15 

jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt

交互式 `telnet/nc localhost 30000`
管道   `echo "fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq" | nc localhost 30000`

## level 15 to 16 

JQttfApK4SeyHwDlI9SXGR50qclOAil1

用TLS/SSL

`openssl s_client -connect localhost:30001`

## level 16 to 17 

ssh private key credencial: 

```text
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

scan the port and check TLS/SSL:

`nmap -sT -p 31000-32000 --script ssl-cert localhost`

把密钥保存（bandit17),改权限 `chmod 600 bandit17`, 然后登录 `ssh -p 2220 -i bandit17 ...`

## level 17 to 18 

hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg

`diff pass*` 

## level 18 to 19 

awhqfNnAbc1naukrpqDYcF95h7HoMTrC

不用shell `ssh -p 2220 bandit18@bandit.labs.overthewire.org 'cat ~/readme'`

或者用`... 'cat /etc/shells'找一个bash的替代，比如/bin/dash

然后登录 `ssh -p 2220 -t bandit18@... /bin/dash`

## level 19 to 20 

VxCazJaVykI6W36BkBU0mJTCM8rR95XT

这里用到setuid

`-rwsr-xr-x 1 root root 72056 Nov 23  2022 /usr/bin/passwd`

修改密码即是修改`/etc/shadow`文件，但是该文件仅root用户有权限修改

普通用户之所以能修改自己的密码则是因为`passwd`有setuid位`s`,所以普通用户能够暂时以root（passwd的owner）身份修改密码

通过家目录下的bandit20-do，bandit19能暂时以bandit20的身份执行命令

`./bandit20-do cat /etc/bandit_pass/bandit20`

## level 20 to 21 

NvEJF7oVjkddltPSrdKEFOllh9V1IBcq

需要两个session，一个发送，一个接收。

可以开两个终端，不过下面将使用terminal multiplexer终端复用器tmux.

[tmux教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)

进去tmux后，`tmux split-window -h`开左右0和1两个窗格，1窗格用`nc -lvp 12345`命令监听12345端口，然后按快捷键`Ctrl+B ;`切换回0窗格，`./suconnect 12345`, 再切回1窗格，输入bandit20的密码。

## level 21 to 22 

WdDozAdTM2z9DiFEQ2mGlwngMfj4EZff

`/etc/cron.d/cronjob_bandit22`每次reboot，每分钟都执行`/usr/bin/cronjob_bandit22.sh`，查看脚本便知道bandit22的密码在`/tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv`

## level 22 to 23 

QYw0Y2aiA672PsMmh9puTQuhoz8SyR2G

查看用户bandit23的cronjob所执行的/usr/bin/cronjob_bandit23.sh脚本，密码在/tmp/$(mytarget)

运行`echo I am user bandit23 | md5sum | cut -d ' ' -f 1`得到文件名，从而拿到密码

## level 23 to 24 

VAfGXJ1PBSsPSnvsjI8p759leLZ9GGar

**切忌**写完脚本不加可执行权限

bandit24的cronjob是重启后及每隔一分钟执行/usr/bin/cronjob_bandit24.sh脚本，该脚本执行/var/spool/bandit24/foo目录下，owner为bandit23的所有文件，时限60s，然后删除文件

所以写个脚本，把/etc/bandit_pass/bandit24的内容cat到/tmp目录下，然后bandit23用户就有read权限，从而拿到bandit24密码

## level 24 to 25 

p7TaowMYrmu23Ol8hiZh9UvD0O9hpx8d

网页上说不需要每次都创建新连接，可以把密码组合输出到文件，再一次性cat到连接里。

先用mktemp命令创建临时文件作为input，然后`seq -w 0 9999 | xargs -I {} echo 'VAfGXJ1PBSsPSnvsjI8p759leLZ9GGar {}' >> input`

然后为daemon的输出也创建一个临时文件2作为output，最后用uniq一下就筛选出密码了

`cat input | nc localhost 30002 > output`

`uniq output`

如果没有筛选出密码，检查output行数，可能连接中断了，可以分几次完成遍历。

## level 25 to 26 

c7GvcKlw9mC7aUQaPx7nwFstuAIBw1o1

登录25会发现上一级的pin保存在`~/.pin`，是9015

找出bandit26的shell

`cat /etc/passwd | grep bandit26`

再检查发现showtext是个脚本，用户登录后执行的是`more ~/text.txt`。

所以尝试登录bandit26会进入more命令，print的bandit26字样则是text.txt的内容。

有less/more（less is more）命令使用经验的都清楚，当内容无法在一页内显示的时候，可以按j下翻，v还默认打开vim

所以在登录bandit26时，把窗口缩窄，使得text.txt的内容（也就是bandit26字样）显示不全，等于停在more命令的界面，然后按v进入vim。

vim用`:!command`是可以执行shell命令的，不过bandit26的shell就相当于`more ~/text.txt`，所以行不通

密码都存在/etc/bandit_pass/，所以用vim查看bandit26密码就行

`:view /etc/bandit_pass/bandit26`

## level 26 to 27 

YnQpBuifNMas1hcUFk70ZmqkhUU2EuaS

书接上回，登录bandit26，从more进入vim，上一级的方法行不通了，因为bandit26没权限看bandit27的文件。

可以修改vim的shell option为bash，然后进bash

`:set shell=/bin/bash`

`:shell`

进了bash用bandit2-do程序（setuid）拿到bandit27的密码

## level 27 to 28 

AVanL161y9rsbcJIsFHuw35rjaOM19nR

先`mktemp -d`, 切换目录

`git clone ssh://bandit27-git@localhost:2220/home/bandit27-git/repo.git`

## level 28 to 29 

tQKvmcwNYcFS6vmPHIUSI3ShmsrQZK8S

clone下来，回退一个版本

git reset命令的`--hard`选项会在回退同时覆盖当前的工作区，默认是`--soft`选项不覆盖，所以回退后再手动restore，`git restore README.md`

## level 29 to 30 

xbhV3HpNGlTIdnjUrdAlPzc2L6y9EOnS

README提示`<no passwords in production!>`,所以切换branch即可

`git branch -a`列出分支, 然后切换到dev即可

## level 30 to 31 

OoffzGDlzhAlerFJ2cAiz1D41JW1Mhmt

[git有tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

`git tag` 列出tag

`git show secret`

## level 31 to 32 

rmCBvG56y58BXzv98yZGdO7ATVL5dW8y

把`.gitignore`删掉或者修改让它不再忽略txt文件，然后按要求push就行了

## level 32 to 33 

odHo63fHiFqcWWJG9rLiLDtPm45KzUKy

特殊变量`$0`

然后直接进了bandit33的shell

**bandit到此结束**
