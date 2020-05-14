import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/states/UserModel.dart';
import 'package:fluttergithub/widgets/MyDrawer.dart';
import 'package:fluttergithub/widgets/RepoItem.dart';
import 'package:fluttergithub/widgets/personDetail/repo_list.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations
            .of(context)
            .home),
      ),
      body: _buildBody(context),
      drawer: MyDrawer(),
    );
  }

}
//构建主页面
Widget _buildBody(context) {
  UserModel userModel = Provider.of<UserModel>(context);
  if (!userModel.isLogin) {
    //用户未登录，显示登录按钮
    return Center(
      child: RaisedButton(
        child: Text(GmLocalizations
            .of(context)
            .login),
        onPressed: () => Navigator.of(context).pushNamed("login"),
      ),
    );
  } else {
    //已登录，则展示项目列表
    var userName = Global.prefs.getString(Constant.USER_NAME_KEY);
    return repoListWidget(context: context,userName: userName);
  }
}