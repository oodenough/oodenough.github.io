---
categories: w program
tags: [program]
title: "binary program用机器语言编程"
---

先写一个C语言程序 
```C
#include <stdio.h>
{
    printf("hello world");
    return 0;
} #==> 这是一段输出hello world的C语言代码
```

```bash
#==>将上述代码保存为hello.c
gcc hello.c -o hello.out #==>编译
./hello.out #==>执行 然后就会看到输出
```
其实这个编译后的`hello.out`就是一个二进制文件(0和1)

接下来尝试把这个二进制文件里的0和1`print`出来
```bash
cat hello.out
#==>这只会输出乱码
_cxa_finalize@@GLIBC_2.2.5
.symtab.strtab.shstrtab.interp.note.gnu.property.n
ote.gnu.build-id.note.ABI-tag.gnu.hash.dynsym.d
ynstr.gnu.version.gnu.version_r.rela.dyn.rela.plt.init.plt.got.plt.sec.text.fi
ni.rodata.eh_frame_hdr.eh_frame.init_array.fini_array.dynamic.data.bss.comment#886XX$I|| W���o��a
                                                          ��ipp�q���o��~���((�B��   �@@�PP�``����
�
  
   D�P ������=�-��?�@0
                    @00+@0.     X6^8�%
```
这是因为`cat`命令输出的应该是文本文件 比如说一个`.txt`文件
而编译后的所谓可执行文件`hello.out`是一个二进制文件 

接下来是正确的输出
```bash
╰─$ xxd -b a.out | cut -d' ' -f2- 
#==> 使用xxd命令 将二进制文件以0和1文本的形式在终端输出
```
一下是部分输出的结果
```bash
00000000 00000000 00000000 00000000 00000000 00000000  ......
10111000 00101111 00000000 00000000 00000000 00000000  ./....
00000000 00000000 01001000 00000000 00000000 00000000  ..H...
00000000 00000000 00000000 00000000 00000000 00000000  ......
#==> 0和1就是二进制内容 ......这一部分是二进制中printable的部分 即在ASCII代码中代表的字符 是xxd生成的 并不是元原二进制文件的内容
```



