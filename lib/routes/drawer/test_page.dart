import 'package:flutter/material.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/routes/drawer/index.dart';
import 'package:fluttergithub/routes/drawer/trend/trend_page.dart';
import 'package:fluttergithub/routes/search_page.dart';
import 'package:fluttergithub/states/index.dart';

import '../person_detail_page.dart';
import '../repo_list_page.dart';
import 'repos_history_page.dart';

class TestRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TestRouteState();
  }
}

class _TestRouteState extends State<TestRoute>{
  var _position = 0;
  final iconsMap = {
    "仓库": Icons.mode_comment,
    "关注": Icons.star,
    "热度": Icons.favorite,
    "我的": Icons.person,
  };
  List<String> get iconsMapKey => iconsMap.keys.toList();
  var activeColor = Colors.white;
  List <Widget>_pageList = List();


  void initState() {
    super.initState();
    _pageList.add(RepoListRoute(title: "我的仓库",personName: UserModel().user.login,isStarredRepoList: false,));
    _pageList.add(RepoHistoryPage());
    _pageList.add(TrendRoute());
    _pageList.add(PersonDetailPage(name:UserModel().user.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => goToPage(context: context, page: SearchPage()),
          child: Icon(Icons.search),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        bottomNavigationBar: _buildBottomAppBar(),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
        body: IndexedStack(
          index: _position,
          children: _pageList,
        ),
      );
  }
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 1,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Theme.of(context).primaryColor,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: iconsMapKey.asMap().keys.map((i) => _buildChild(i)).toList()
            ..insertAll( 2, [SizedBox(width: 30)])),
    );
  }

  Widget _buildChild(int i) {
    var active = i == _position;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => _position = i),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Icon(
              iconsMap[iconsMapKey[i]],
              color: active ? activeColor : Colors.white60,
              size: 25,
            ),
            Text(iconsMapKey[i],
                style: TextStyle(
                    color: active ? activeColor : Colors.white60, fontSize: 14)),
          ],
        ),
      ),
    );
  }

}