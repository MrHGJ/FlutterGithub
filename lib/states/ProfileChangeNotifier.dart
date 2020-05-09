import 'package:flutter/cupertino.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  ProfileBean get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners();
  }
}
