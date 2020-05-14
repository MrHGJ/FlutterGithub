import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/states/ProfileChangeNotifier.dart';

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果未设置主题，则默认使用蓝色主题
  Color get theme => Global.themes
      .firstWhere((e) => e.value == profile.theme, orElse: () => Global.themes[0]);

// 主题改变后，通知其依赖项，新主题会立即生效
  set theme(Color color) {
    if (color != theme) {
      profile.theme = color.value;
      notifyListeners();
    }
  }
}
