import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/res/icons.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/routes/search_page.dart';
import 'package:fluttergithub/states/UserModel.dart';

import 'drawer/repos_history_page.dart';
import 'drawer/trend/trend_page.dart';
import 'person_detail_page.dart';
import 'repo_list_page.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  var _position = 0;
  var iconsMap;

  List<String> iconsMapKey;
  var activeColor = Colors.white;
  List<Widget> _pageList = List();

  void initState() {
    super.initState();

    _pageList.add(RepoListRoute(
      title: "我的仓库",
      personName: UserModel().user.login,
      isStarredRepoList: false,
    ));
    _pageList.add(RepoHistoryPage());
    _pageList.add(TrendRoute());
    _pageList.add(PersonDetailPage(name: UserModel().user.login));
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    iconsMap = {
      gm.repositories: MyIcons.repos,
      gm.footprint: MyIcons.footprint_fill,
      gm.trend: MyIcons.trend,
      gm.me: Icons.person,
    };
    DateTime _lastPressedAt; //上次点击时间
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToPage(context: context, page: SearchPage()),
        child: Icon(Icons.search),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WillPopScope(
        child: IndexedStack(
          index: _position,
          children: _pageList,
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
            //两次点击间隔超过1s则重新计时
            _lastPressedAt = DateTime.now();
            showToast("再返回一次退出应用");
            return false;
          }
          return true;
        },
      ),
    );
  }
  Widget _buildBottomAppBar() {
    iconsMapKey=iconsMap.keys.toList();
    return BottomAppBar(
      elevation: 1,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Theme.of(context).primaryColor,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: iconsMapKey.asMap().keys.map((i) => _buildChild(i)).toList()
            ..insertAll(2, [SizedBox(width: 30)])),
    );
  }

  Widget _buildChild(int i) {
    var active = i == _position;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 8.0),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Icon(
              iconsMap[iconsMapKey[i]],
              color: active ? activeColor : Colors.white60,
              size: 25,
            ),
            Text(iconsMapKey[i],
                style: TextStyle(
                    color: active ? activeColor : Colors.white60,
                    fontSize: 12)),
          ],
        ),
      ),
      onTap: () => setState(() => _position = i),
    );
  }
}
