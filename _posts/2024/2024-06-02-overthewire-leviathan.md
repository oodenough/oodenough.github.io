---
title: Overthewire Leviathan 通关
pin: false
---

[leviathan](https://overthewire.org/wargames/leviathan/)

## level 0

leviathan0:leviathan0

login with `ssh -p 2223 leviathan0@leviathan.labs.overthewire.org`

这一次网页上没有提供每一个level的信息，密码自己找。

唯一的信息是不要求编程知识，只需要常识跟`*nix`命令。

数据都在家目录，密码都在`/etc/leviathan_pass`。

## level 0 to 1

leviathan1:PPIfmI1qsA

去`~/.backup/bookmarks.html`里搜索*leviathan*。

## level 1 to 2

leviathan2:mEh5PNl10e

卡关了。原来*常识*指的是相关的专业知识（程序的动态链接库），还用到了不认识的[ltrace](https://en.wikipedia.org/wiki/Ltrace)命令。[参考这篇博客](https://mayadevbe.me/posts/overthewire/leviathan/level2/).

执行`ltrace ~/check`,随便输入一个密码，发现程序使用`strcmp`函数来判断密码是否正确：

```bash
strcmp("fff", "sex")                             = -1
puts("Wrong password, Good Bye ..."Wrong password, Good Bye ...
)             = 29
```

显然用散列值更安全。

然后进了leviathan2的shell。因为`check`有`SUID`，[Bandit 19 to 20](https://oodenough.github.io/posts/overthewire-bandit/#level-19-to-20)里见到过。

# level 2 to 3

leviathan3:Q0G8j4sakn

看[这篇博客](https://mayadevbe.me/posts/overthewire/leviathan/level3/)

先研究程序行为。

用ltrace加在命令前就不会有输出，我猜ltrace是分析了程序会执行`/bin/cat filename`命令，然后以当前用户leviathan2的身份去执行，所以软链接显示permission denied.而如果实际运行`printfile`则是SUID以leviathan3的身份去运行，所以有输出。

## level 3 to 4

leviathan4:AgvropI4OA

用ltrace

## level 4 to 5

leviathan5:EKKlTF1Xqs

二进制转成ascii

## level 5 to 6

leviathan5:YZ55XPVk2l

`ln -s /etc/leviathan_pass/leviathan6 /tmp/file.log`

## level 6 to 7

leviathan7:8GpZ5f8Hze

暴力破解4位数密码。

`for i in {0000..9999}; do ~/leviathan6 $i; done`

下面这个就行不通

`seq -w 0 9999 | xargs -I {} ~/leviathan6 {}`

如果leviathan6这个程序在输入正确密码后的行为是输出到stdout的话，seq加xargs是可行的。但如果是在shell里执行其他命令，比如通过setuid进其他用户的shell，那就不一定会成功。

我也不知道为什么，用python自己测试了一下，`top`命令就不行，vim又可以。

## level 7 to 8

没了，就到level7.

## 总结

这里头最好玩的就是ltrace了哈哈。
