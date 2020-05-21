import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/routes/drawer/trend/trend_page_developers.dart';
import 'package:fluttergithub/routes/drawer/trend/trend_page_repos.dart';
import 'package:fluttergithub/widgets/MyDrawer.dart';

class TrendRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendRouteState();
  }
}

class _TrendRouteState extends State<TrendRoute>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  TabController _tabController;
  String _language; //选择的开发语言
  String _since; //选择的时间段(日、周、月)
  int _currentIndex = 0; //当前选择的tab
  bool _isChange = false;

  @override
  void initState() {
    super.initState();
    _since = 'daily';
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    final List<Choice> choices = List(2);
    choices[0] = Choice(title: gm.repos);
    choices[1] = Choice(title: gm.developers);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
          labelPadding: EdgeInsets.all(8.0),
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 16),
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: choices
              .map((Choice choice) => Tab(
                    text: choice.title,
                  ))
              .toList(),
          onTap: (index) {
            _currentIndex = index;
            _pageController.jumpTo(getScreenWidth(context) * index);
            if (_isChange) {
              _isChange = false;
              if (_currentIndex == 0) {
                //refreshReposData
              } else {
                //refreshDevelopersData
              }
            }
          },
        ),
      ),
      drawer: MyDrawer(),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          TrendReposRoute(),
          TrendDevelopersRoute(),
        ],
        onPageChanged: (index){
          _currentIndex = index;
          _tabController.animateTo(index);
          if(_isChange){
            //refreshData
          }
        },
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}
