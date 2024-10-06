---
title: 成为Linux用户
categories: [OS, Linux]
tags: [GNU, VeraCrypt, Arch Linux, Ubuntu, ZorinOS]
pin: false
image:
  path: ./assets/img/2024/linux.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Linux Mascot
---

大概三四个月前，我删除了windows系统，正式成为了[2.09%](https://truelist.co/blog/linux-statistics/)的linux用户。

在这里想回顾一下我认识、学习linux的历程，然后再谈谈过去三四个月我的Linux使用体验。

## 初闻Linux

最初听说[Linux](https://zh.wikipedia.org/wiki/Linux)是在计算机科学导论的课堂上，当时对Linux尚且一无所知。

对Linux的进一步了解是通过网络搜索，当时经由同学推荐，用[csdn](https://csdn.net)了解的较多，在知乎上也看到过一些linux相关的回答。我还能记起来的大概是些“linux更安全”、“linux更适合developer"等说法。这些说法刺激了我的好奇心，于是我开始在互联网的各个地方搜寻linux的信息。

请记住，那时的我尚且是一个计算机小白 ---- 打开Chrome浏览器什么都搜索不出来然后一脸懵的那种程度  ，所谓"互联网的各个地方"无外乎B站和当时被我奉为圭臬的csdn。

当时在B站看[Micro_Frank](https://space.bilibili.com/19658621)的课程，刚开始看他关于windows系统的系列视频 ---- 因为我实在是小白一个。我想我同时还在看[廖雪峰的git教程](https://www.liaoxuefeng.com/wiki/896043488029600),总之那时刚刚接触计算机，好奇心非常旺盛，对什么都非常感兴趣。通过各种折腾，算是能够熟悉使用windows系统。然后呢也认识到要想进一步探索linux，最好是先在虚拟机里安装使用linux。

## Vmware安装Linux

跟着B站[Micro_Frank的虚拟机视频教程](https://www.bilibili.com/video/BV18U4y1W7av/?spm_id_from=333.999.0.0&vd_source=30f04da6dc63cfeb48fe0498c0dcec14),我成功在Vmware里安装了Ubuntu虚拟机。

接着呢我就开始下载安装各种linux虚拟机，debian、fedora、zorin、kali等等，各种千奇百怪，甚至装了一个BSD。当时很喜欢Vmware侧边栏里躺满linux虚拟机的感觉，windows虚拟机也有装。随之而来的是存储空间的不足，同时我也第一次发现了windows的庞大。虽然这时我有安装各种虚拟机，但我的注意力总被每个distribution风格各异的桌面所吸引。对Linux的使用也局限于搜索csdn，`Ctrl + Alt + T`打开酷酷的终端，然后跟着csdn上的教程无脑键入命令，再无脑回车。

我这时在虚拟机里的linux使用其实非常有限。

后来一段时间我对于linux的exploration甚至陷入了停滞：Vmware里躺着一堆虚拟机，我可以在终端用vim写个C语言hello world程序，然后用gcc编译并执行，但更多的我便举足维艰。

## Archlinux与LinuxBible

情况在archlinux这里发生了改变。我虽然装了很多虚拟机，但是大同小异，这些虚拟机无一不是通过GUI在Vmware里完成安装的，安装过程可能也就分盘对于我这样的新手比较麻烦,其他的步骤都很简单。

Archlinux吸引我的首先是它极简的理念。然后是它的“不适合新手”。曾在网上看到说如果能成功安装archlinux， 那就再没有哪个linux发现版的安装能难倒你了。

然而archlinux的安装实在不简单，具体内容可以看[这篇博客](https://oodenough.github.io/posts/How-to-install-Arch-Linux/)。尤记得我折腾了整整三天才装上。这里的重点在于archlinux的整个安装过程都要使用命令行进行，如果对所执行的命令一无所知的话很容易出错。事实上我的第一次成功安装不过是跟着Youtube上的视频一步步照搬。

后来我看了[Linux Bible](https://www.amazon.com/Linux-Bible-Christopher-Negus/dp/1119578884/ref=sr_1_1?crid=1BGPD481DDFDD&keywords=linux+bible&qid=1706604509&sprefix=linux+b%2Caps%2C597&sr=8-1)这本书，虽然只看了前面几章就坚持不下去了，但是这几章为我建立起了对linux命令行/终端/Shell的一个基本了解，当初在安装archlinux时敲的各种命令在我眼里也有了一定的含义。对命令行的了解也不是看个几章书就能搞定的，还要多练多用。当时我还开始写博客了，[如何安装archlinux](https://oodenough.github.io/posts/How-to-install-Arch-Linux/)这篇博客在csdn也发过，再加上使用linux也不是一帆风顺的，我就弄坏过两三次系统，补救不过来的话就得重装......总之我是各种折腾，单archlinux我就装过不下10次。再加上一些其他的 `折腾`，比如[oh my zsh](https://oodenough.github.io/posts/Oh-my-zsh/),我在面对linux的终端时总算不至于不知所措，看网上的教程时也不再无脑照搬命令行，而是试着去理解那条命令。

这时我的linux使用体验已经得到很大提升了。但是在Vmware里使用虚拟机总觉得不过瘾，于是我开始尝试实际安装使用linux。

## 双系统、三系统

怎么装就略过，网络上教程一大堆。如前所述，装来装去，我对archlinux的安装可谓是“无他,唯手熟尔”，所以首先安装了windows+archlinux双系统。archlinux里我也不装桌面，就一个[i3](https://i3wm.org/), 酷的不行。还尝试了[IRC](https://en.wikipedia.org/wiki/Internet_Relay_Chat)聊天。总之就是 `折腾`。

其实从使用linux的某个时间点起我就一直想要将windows换掉。但是安装在我电脑上的linux一直[没有声音输出](https://consumer.huawei.com/en/community/details/Matebook-14-2021-Ubuntu-Linux-No-Sound/topicId_169472/),再加上担心linux无法完成windows下office套件的日常办公任务，我一直没敢贸然删除windows。

但我一直想要换掉windows。

于是安装了[zorinOS](https://consumer.huawei.com/en/community/details/Matebook-14-2021-Ubuntu-Linux-No-Sound/topicId_169472/)+archlinux+windows三系统。zorinOS是一个在linux下提供windows使用体验的发行版，至于三系统嘛，安装的时候我并没有什么把握。

有一段时间，我开机后都直奔zorinOS。大部分时间都是在firefox里上网，也有看电子书。还在zorinOS里尝试过用[LibreOffice](https://www.libreoffice.org/)替代windows office。

可是最后我又换回了windows。

## Back to Windows

虽然zorinOS很漂亮，也能上个网，但是没声音很让我头疼，我以后岂不是连个电影都看不了？还有就是我还怎么打游戏？当时的我完全不能把游戏跟linux联系在一起。再加上我的强迫症犯了：装了仨系统，还不算Vmware里那些虚拟机，我哪用得了这么多？

于是我开始删系统，事实上删系统时还删出了问题，比如[windows无法正常启动](https://oodenough.github.io/posts/how-to-repair-windows-efi-partition/)。删到只剩windows，删到windows的Vmware里只剩一两台虚拟机。

接下来的故事是我抛弃了linux，跟windows过上了快乐幸福的生活，有音乐，有游戏......

`The End`

桥豆麻袋！我不是在分享自己怎么成为linux用户的吗，怎么会是这样的结局？

其实我离彻底放弃windows转而使用linux只差一个契机。在写这个契机之前首先要讲讲开源与自由软件。

## 若为自由故

在探索linux的旅途中，我阅读了linux之父[Linus](https://zh.wikipedia.org/wiki/%E6%9E%97%E7%BA%B3%E6%96%AF%C2%B7%E6%89%98%E7%93%A6%E5%85%B9)的自传[Just for Fun](https://www.aMSzon.com/Just-Autobiography-Lynus-Father-Linux/dp/7115361649/ref=sr_1_1?crid=1L6U2R4WM1KD4&keywords=%E5%8F%AA%E6%98%AF%E4%B8%BA%E4%BA%86%E5%A5%BD%E7%8E%A9&qid=1706610013&sprefix=%E5%8F%AA%E6%98%AF%E4%B8%BA%E4%BA%86%2Caps%2C1534&sr=8-1),增加了一些对linux历史以及开源运动的了解。还阅读了GNU创立者[RMS](https://zh.wikipedia.org/wiki/%E7%90%86%E6%9F%A5%E5%BE%B7%C2%B7%E6%96%AF%E6%89%98%E6%9B%BC)的传记[Free as in Freedom](https://www.amazon.com/%E8%8B%A5%E4%B8%BA%E8%87%AA%E7%94%B1%E6%95%85-%E8%87%AA%E7%94%B1%E8%BD%AF%E4%BB%B6%E4%B9%8B%E7%88%B6%E7%90%86%E6%9F%A5%E5%BE%B7%C2%B7%E6%96%AF%E6%89%98%E6%9B%BC%E4%BC%A0%EF%BC%88%E5%BC%82%E6%AD%A5%E5%9B%BE%E4%B9%A6%EF%BC%89-Chinese-Sam-Williams-ebook/dp/B00YQRZRZ6/ref=sr_1_1?crid=1CKY7K51KQLNZ&keywords=%E8%8B%A5%E4%B8%BA%E8%87%AA%E7%94%B1%E6%95%85&qid=1706610288&sprefix=free+as+in+freedom%2Caps%2C462&sr=8-1)。毕竟linux的全称是GNU/Linux（有[争议](https://zh.wikipedia.org/zh-hans/GNU/Linux%E5%91%BD%E5%90%8D%E7%88%AD%E8%AD%B0)）。

软件与自由的话题我就不多谈了，在[RMS的个人网站](https://stallman.org/)上有很多相关的文字可供阅读，[gnu官网](https://www.gnu.org/)上还有一个很不错的介绍视频。

{% include embed/bilibili.html id='BV1LC411r7o6' %}

## 契机

促使我完全卸载windows的契机其实来自一条网络消息，说是某单位强制人员携带电脑，现场为其安装监控软件。看到消息后我很着急，于是几小时内我便备份完数据删除windows了。当时仍然是打算安装windows, 不过要装成[veracrypt的hidden os](https://veracrypt.eu/en/Hidden%20Operating%20System.html)，可惜折腾一天没装上（我总结是因为U盘不够哈哈，应该一个启动盘用来安装，两个key盘分别用来解锁两个windows，可惜我只有俩U盘，少一个key，到最后了解锁不了系统前功尽弃），最后干脆装了Ubuntu 22.04。

`The End`

[Ubuntu使用体验]另写一篇来谈算了。

