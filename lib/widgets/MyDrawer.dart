import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/routes/drawer/follow_list_page.dart';
import 'package:fluttergithub/routes/login_page.dart';
import 'package:fluttergithub/routes/repo_detail_page.dart';
import 'package:fluttergithub/routes/person_detail_page.dart';
import 'package:fluttergithub/routes/repo_list_page.dart';
import 'package:fluttergithub/states/UserModel.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //移除顶部padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(), //构建抽屉菜单头部
            Expanded(child: _buildMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 70, bottom: 50),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                    child: value.isLogin
                        ? myAvatar(value.user.avatar_url, width: 80)
                        : Image.asset(
                            "imgs/avatar_default.png",
                            width: 80,
                          ),
                  ),
                ),
                Text(
                  value.isLogin
                      ? value.user.login
                      : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) {
              Navigator.of(context).pushNamed("login");
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PersonDetailPage(name: UserModel().user.login),
                ),
              );
            }
          },
        );
      },
    );
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
//            ListTile(
//              leading: const Icon(Icons.trending_up),
//              title: Text(gm.trend),
//              onTap: () => Navigator.pushNamed(context, "trend"),
//            ),
//            ListTile(
//                leading: const Icon(Icons.folder_shared),
//                title: Text("我的仓库"),
//                onTap: (){goToPage(context: context, page:RepoListRoute(title: "我的仓库",personName: UserModel().user.login,isStarredRepoList: false,));}
//            ),
            ListTile(
                leading: const Icon(Icons.star),
                title: Text(gm.myStarRepos),
                onTap: () {
                  goToPage(
                      context: context,
                      page: RepoListRoute(
                        title: gm.myStarRepos,
                        personName: UserModel().user.login,
                        isStarredRepoList: true,
                      ));
                }),
            ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(gm.myFollow),
                onTap: () {
                  goToPage(
                      context: context,
                      page: FollowListPage(
                          "Following List", UserModel().user.login));
                }),
//            ListTile(
//                leading: const Icon(MyIcons.footprint_fill),
//                title: Text("足迹"),
//                onTap: (){goToPage(context: context, page: RepoHistoryPage());}
//            ),
//            ListTile(
//                leading: const Icon(Icons.search),
//                title: Text("搜索"),
//                onTap: (){goToPage(context: context, page: SearchPage());}
//            ),
            ListTile(
                leading: const Icon(MyIcons.github_fill),
                title: Text(gm.thisProject),
                onTap: () => goToPage(
                    context: context,
                    page: RepoDetailRoute("MrHGJ", "FlutterGithub"))),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
//            ListTile(
//              leading: const Icon(Icons.accessible),
//              title: Text(gm.test),
//              onTap: () => Navigator.pushNamed(context, "test"),
//            ),
            Visibility(
              visible: userModel.isLogin,
              child: ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //退出账号前先弹二次确认窗
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(gm.cancel),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(gm.yes),
                            onPressed: () {
                              //该赋值语句会触发MaterialApp rebuild
                              userModel.user = null;
                              Global.prefs.remove(Constant.IS_LOGIN_KEY);
                              Global.prefs.remove(Constant.BASIC_KEY);
                              //隐藏对话框
                              Navigator.pop(context);
                              //退出当前页面
//                              Navigator.pop(context);
//                              goToPage(context: context, page: LoginRoute());
                              // (route) => false 清除当前所有页面，并跳转到LoginRout登录页面
                              Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                                builder: (context) => LoginRoute(),
                              ), (route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
