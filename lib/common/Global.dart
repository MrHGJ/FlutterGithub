import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CacheObject.dart';
import 'net/NetApi.dart';

const _themes = <Color>[
  Color(0xFF212121),
  Color(0xFF303030),
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences prefs;
  static ProfileBean profile = ProfileBean();

  //网络缓存对象
  static NetCache netCache = NetCache();

  //可选主题列表
  static List<Color> get themes => _themes;

//是否为release版本
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

//初始化全局信息，会在App启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    var _profile = prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = ProfileBean.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    //如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfigBean()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    //初始化网络请求相关配置
    NetApi.init();
  }

  //持久化Profile信息
  static saveProfile() =>
      prefs.setString("profile", jsonEncode(profile.toJson()));
}
