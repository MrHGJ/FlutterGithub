## FlutterGithub

![](./demo/logo.png)


### 用Flutter实现的一款界面精美、功能较全的Github客户端。支持多语言、换肤等功能。代码有充分注释、简单易懂，很适用于学习Flutter。



## 界面展示

<div align:left;display:inline;>
<img width="203" height="438" src="./demo/demo1.jpg"/>
<img width="203" height="438" src="./demo/demo2.jpg"/>
<img width="203" height="438" src="./demo/demo3.jpg"/>
<img width="203" height="438" src="./demo/demo4.jpg"/>
</div>
<div align:left;display:inline;>
<img width="203" height="438" src="./demo/demo5.jpg"/>
<img width="203" height="438" src="./demo/demo6.jpg"/>
<img width="203" height="438" src="./demo/demo7.jpg"/>
<img width="203" height="438" src="./demo/demo8.jpg"/>
</div>
<div align:left;display:inline;>
<img width="203" height="438" src="./demo/demo9.jpg"/>
<img width="203" height="438" src="./demo/demo10.jpg"/>
<img width="203" height="438" src="./demo/demo11.jpg"/>
<img width="203" height="438" src="./demo/demo12.jpg"/>
</div>

## 下载体验
点击链接下载[https://github.com/MrHGJ/FlutterGithub/raw/master/apk/flutterGithub.apk]

或扫码下载apk进行体验： 
  <br>
![](./demo/qr_code.png)
  <br>

## 功能特性
- **登陆页和首页：**
  <br>
![](./demo/gif-login.gif)
  <br>
- **换肤功能：**
  <br>
![](./demo/gif-theme.gif)
  <br>
- **搜索功能：**
  <br>
![](./demo/gif-search.gif)
  <br>
- **浏览源码：**
  <br>
![](./demo/gif-code.gif)
  <br>
- **项目详情：**
  <br>
![](./demo/gif-repo.gif)
  <br>
- **个人详情：**
  <br>
![](./demo/gif-person.gif)
  <br>
## 开始使用
1. 配置好flutter环境；
2. clone本项目：
```
$ git clone https://github.com/MrHGJ/FlutterGithub.git
```
3. **注意点：**需要注册一个Github的OAuth application，替换项目中的`clientId`和`clientSecret`（位置：**./lib/common/constant/ignore.dart**）；
申请地址：[https://github.com/settings/applications/new](https://github.com/settings/applications/new)信息可以随便填写，没有什么具体要求。例如下图所示，填完后提交即可得到client_id和client_secret；
![](./demo/github-tip.jpeg)
4. 大功告成，直接运行即可；
5. 登录用github用户名和密码（暂不支持邮箱登陆）。

## 代码结构
![](./demo/code-structure.png)
- **fonts** 自定义的图标文件资源，.ttf格式；

- **imgs** 图片资源；

- **jsons** 存放生成Model类的json数据格式；

- **l10n-arb** 多语言相关资源；

- **lib**

  -- **common** 存放通用的类。例如全局变量、eventbus、网络请求、常用工具类等。
  
  -- **db** SQLite数据库相关类。
  
  -- **l10n** 多语言。
  
  -- **models** jsons文件夹对应的Dart Model实例类。
  
  -- **res** 资源文件。例如颜色、图片、自定义Icon图标、字体样式等。
  
  -- **routes** 存放所有页面路由类。
  
  -- **states** 保存APP中需要跨组件共享的状态类。
  
  -- **widges** 可复用的、常用的、封装的widget类。
  
  -- **main.dart** 程序入口。

## 相关文章
- [**Flutter InfiniteListView学习与扩充**](https://blog.csdn.net/qq_34484722/article/details/106551197)
- [**Github API (flutter调用)**](https://blog.csdn.net/qq_34484722/article/details/106540418)
- [**Flutter App显示Github Readme文档**](https://blog.csdn.net/qq_34484722/article/details/106541277)
- [**webview_flutter插件使用时报错**](https://blog.csdn.net/qq_34484722/article/details/106543039)
- [**Flutter调试和打包**](https://blog.csdn.net/qq_34484722/article/details/106543282)
- [**Flutter页面切换状态维持**](https://blog.csdn.net/qq_34484722/article/details/106543453)
- [**Flutter图片蒙层背景的实现**](https://blog.csdn.net/qq_34484722/article/details/106550071)

## 第三方框架

库|功能
:--:|:--:
flutter_localizations和intl|国际化
shared_preferences|SharedPreference本地缓存
dio|网络请求
cached_network_image| 加载网络图片并使用缓存
provider|状态管理
fluttertoast|toast显示
flutter_markdown|显示markdown格式
flukit|工具类，项目中主要使用了上拉加载更多列表InfiniteListView
flutter_spinkit|炫酷的loading样式
webview_flutter|提供webview支持
event_bus|事件总线
sqflite|sqlite 数据库
photo_view|使图像能够通过用户手势（例如捏，旋转和拖动）进行缩放和平移
## 感谢
❤️ 学习flutter主要参考了[《Flutter实战》](https://book.flutterchina.club/)
❤️ 项目部分参考并借鉴 [GSYGithubAppFlutter](https://github.com/CarGuo/GSYGithubAppFlutter) 

## License
```
MrHGJ/FlutterGithub is licensed under the
MIT License

Copyright (c) 2020 MrHGJ

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```