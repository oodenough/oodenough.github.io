---
title: Bash脚本入门
pin: false
---

最近看完了[这本](https://github.com/bobbyiliev/introduction-to-bash-scripting)介绍Bash脚本的书。

对Linux感兴趣的你肯定对Bash脚本并不陌生，在折腾Linux和编译奇奇怪怪的开源软件时肯定也执行过Bash脚本，并惊叹于它的神奇。

下面是我的第一个脚本：

```bash
#!/bin/zsh
echo "There was a tenor named Springer,"
echo "Got his testicles caught in a wringer."
echo "	  He hollered in pain"
echo "	  As they rolled down the drain,"
echo "(falsetto):\"There goes my carrer as a singer!\""
```

把这个脚本添加到Shell的配置文件里，这样每次打开终端都会打印这个小笑话。很有意思，它已经陪了我一年多了。

最初我是在纪录片Code Rush中看到的，然后就抄了过来。纪录片B站有转载，[精准空降](https://www.bilibili.com/video/BV19Y4y1i798?t=1120.7)。

找来这本书的原因是最近敲`docker`命令敲太多遍了，我又不想在自己笔记本上装**各种**。所以打算找本Bash脚本的书看看，然后写个脚本把项目的重新部署给自动化一下，免去重复敲相同命令的痛苦。

其他的书也很多，选这本主要因为它内容较少。少看多写，更多的还是要在实践中学习。

下面就是我的学习成果：

```bash
#!/usr/bin/env bash

# color variables
blue='\e[34m'
green='\e[32m'
red='\e[31m'
clear='\e[0m'

# color functions
ColorGreen() {
    echo -ne $green$1$clear
}
ColorBlue() {
    echo -ne $blue$1$clear
}
ColorRed() {
    echo -ne $red$1$clear
}

err_check() {
# 检查命令是否成功执行
# 命令执行成功 输出 $1， 否则输出 $2
    if [[ $? -eq 0 ]]; then
        ColorGreen $1
        echo ""
    else
        ColorRed $2
        exit 1
    fi
}

project=$1

if [[ -z $project ]]; then
    ColorRed "请将项目名称作为脚本参数"
    exit 1
fi

ColorBlue "当前项目📂:"
echo ${project}

ssh root@${server1} "docker compose -f /root/${project}/docker-compose.yml down -v &>/dev/null"
err_check "🐳服务已停止" "服务未停止" 

ColorBlue "开始复制项目文件到:"
echo  🖥️$server1

scp -r . root@${server1}:/root/${project} 1>/dev/null
err_check "复制结束" "文件拷贝错误❌" 

ColorBlue "开始重建容器🐳"
echo ""

ssh root@${server1} "docker compose -f /root/${project}/docker-compose.yml build --no-cache && docker compose -f /root/${project}/docker-compose.yml up -d"
err_check "📂$project 服务已重新部署" "🐳容器部署错误❌" 
```

注意执行远程命令时，只有双引号包裹的命令才会把变量替换成实际的值，单引号就直接原样执行了。

最后附个小抄 <https://devhints.io/bash>