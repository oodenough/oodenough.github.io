---
title: 如何将Qt配置到vscode
image:
  path: ./assets/img/2023/qt-vscode.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Visual Studio Code
---

”将Qt配置到vscode“指的是把`Qt库`添加到vscode，并在vscode中使用`qmake`和`mingw32-make`两个工具完成`C++`Qt项目的构建和编译。

首先在Windows上安装好[vscode](https://code.visualstudio.com/download)和[Qt](https://www.qt.io/download-qt-installer-oss?hsCtaTracking=99d9dd4f-5681-48d2-b096-470725510d34%7C074ddad0-fdef-4e53-8aa8-5e8a876d6ab4)

Linux和Windows类似，只不过安装完成后不需要手动添加环境变量，然后文件路径与Windows不同。

安装Qt时至少勾选**Qt/MinGW**和**Developer and Designer Tools/MinGW**两个组件。

第一个组件包含了Qt库和qmake工具，第二个则包含了mingw32-make。

安装好后将`qmake`的路径`C:\Qt\6.5.2\mingw_64\bin`和`mingw32-make`的路径`C:\Qt\Tools\mingw1120_64\bin`添加到系统环境变量。

路径根据安装时的选项做修改。

## 添加Qt头文件路径

首先在vscode里安装`C/C++`扩展，接下来将对vscode中的`C/C++`这一extension进行设置，也就是添加Qt头文件的路径。该设置是针对项目做修改，不会应用到整个vscode。

先新建一个Qt项目。

新建完成后，在vscode中打开该项目文件夹，按下vscode快捷键`Ctrl+Shift+P`,输入C/C++进行搜索，选择`C/C++:Edit Configurations (JSON)`，然后vscode会再目录下自动创建`.vscode`文件夹，并打开其中的`c_cpp_properties.json`文件，文件内容就是针对本项目的相关设置。

修改configurations/includePath的值为：

`C:/Qt/6.5.2/mingw_64/include/**`

不妨新建一个main.cpp文件测试一下，在main.cpp中添加

`#include <QApplication>`

如果没有红色波浪线报错就说明Qtl头文件添加成功了。

## Qt项目的构建过程

接下来先手动构建、编译一个Qt小程序。

main.cpp

```c++
#include <QApplication>
#include <QPushButton>

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    QPushButton button("hello world");
    button.show();
    return app.exec();

}
```

这个简单程序就是一个输出hello world的按钮。

然后新建`.pro`项目文件。

这个文件里的都是Qt项目的信息，用`qmake`构建项目必须得有它。

`project_name.pro`：

```
TEMPLATE = app
TARGET = hello-world-button

QT = core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

SOURCES += \
    main.cpp \

HEADERS += \
```

`TARGET`的值就是应用的名称。如果项目中有其他源文件需要手动添加到`SOURCES`和`HEADERS`下面.

接下来在命令行构建项目：

```
qmake .\project_name.pro
```

根据生成的`Makefile`编译项目：

```
mingw32-make
```

编译完成后**release**目录下就有hello-world-button.exe程序了。

## 添加vscode的task

不想每一次都手动到命令行编译的话可以将qmake和mingw32-make添加到vscode的task。

按下vscode的`Ctrl+Shift+P`快捷键，搜索task，选择`Tasks: Configure Task`。

或者手动在.vscode目录下创建`tasks.json`：

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "qmake",
            "type": "shell",
            "command": "qmake",
            "group": {
                "kind": "build",
                "isDefault": true
            }
        },
        {
            "label": "mingw32-make",
            "type": "shell",
            "command": "mingw32-make",
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "dependsOn": "qmake"
        }
    ]
}
```

以后构建编译项目只需按vscode的快捷键`Ctrl+Shift+P`，再分别执行qmake任务和mingw32-make任务就行了。

特别说明一下，如果项目文件project_name.pro未做修改的话，不需要每次都重新构建，直接编译就行。
