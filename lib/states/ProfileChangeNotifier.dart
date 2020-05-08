import 'package:flutter/cupertino.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners();
  }
}
