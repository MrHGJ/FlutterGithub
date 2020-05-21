import 'dart:ui';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/common/delegate/index.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/res/styles.dart';
import 'package:fluttergithub/routes/SearchPage/search_page_repos.dart';
import 'package:fluttergithub/routes/SearchPage/search_page_users.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String searchWords;
  var statusBarHeight; //状态栏高度
  TabController tabController;
  Color backColor; //当前页面的主题色，为默认主题色
  TextEditingController _editController = TextEditingController();
  List<String> historyData = new List<String>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    tabController = TabController(length: 2, vsync: this);
    var shareData = Global.prefs.getStringList(Constant.SEARCH_HISTORY_KEY);
    if (shareData != null && shareData.length > 0) {
      historyData.addAll(shareData);
    }
  }

  _beginSearch() async {
    if (_editController.text == null || _editController.text.length <= 0) {
      showToast("搜索内容不能为空");
    } else {
      if (searchWords != null) {
        eventBus.fire(SearchEvent(searchWords: _editController.text));
      }
      setState(() {
        searchWords = _editController.text;
      });
      //如果搜索的字段不在历史记录中，添加到历史记录
      if (!historyData.contains(searchWords)) {
        setState(() {
          historyData.add(searchWords);
        });
      }
      //搜索完成收起软键盘
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget _buildHistory() {
    if (historyData == null || historyData.length == 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
          child: Text(
            '暂时没有搜索记录',
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: historyData.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            color: MyColors.miWhite,
            child: Center(
              child: Text(
                historyData[index],
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          onTap: () {
            _editController.text = historyData[index];
            _beginSearch();
          },
        );
      },
    );
  }

  //清空历史记录
  Future<bool> _showClearHistoryDialog() {
    if (historyData != null && historyData.length > 0) {
      return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("确定要清空所有搜索历史记录吗？"),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      setState(() {
                        historyData.clear();
                      });
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    } else {
      showToast('暂时没有搜索记录。');
    }
  }

  _buildBody() {
    if (searchWords == null || searchWords.length <= 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 60),
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: 150,
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
               child: Text("哥们，搜点啥",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25),)
            )
          ],
        ),),
      );
    } else {
      return TabBarView(
        controller: tabController,
        children: <Widget>[
          SearchPageRepos(
            searchWords: searchWords,
          ),
          SearchPageUsers(
            searchWords: searchWords,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    backColor = Theme.of(context).primaryColor;
    var mTabs = <String>['仓库', "用户"];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //搜索框，一个状态栏大小的背景
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: statusBarHeight + 57,
                maxHeight: statusBarHeight + 57,
                child: Container(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: backColor,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            controller: _editController,
                            autofocus: false,
                            maxLines: 1,
                            style: TextStyle(fontSize: 14),
                            cursorColor: backColor,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (val) {
                              _beginSearch();
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              //密集排布
                              prefixIcon: InkWell(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  _beginSearch();
                                },
                              ),
                              suffixIcon: InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  _editController.clear();
                                },
                              ),
                              hintText: 'Search or jump to...',
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: backColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: backColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              "搜索",
                              style: TextStyle(fontSize: 17, color: backColor),
                            ),
                          ),
                          onTap: () {
                            _beginSearch();
                          }),
                    ],
                  ),
                ),
              ),
            ),
            //搜索历史记录
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 80,
                maxHeight: 110,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: MyColors.miWhite, width: 5),
                          bottom:
                              BorderSide(color: MyColors.miWhite, width: 5))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '搜索历史',
                                style: TextStyle(
                                  color: backColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: InkWell(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () {
                                  _showClearHistoryDialog();
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          height: 40,
                          width: double.infinity,
                          child: _buildHistory(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //状态栏
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 45,
                maxHeight: 45,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TabBar(
                      labelColor: backColor,
                      labelStyle: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: backColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: tabController,
                      tabs: mTabs
                          .map((String label) => Tab(
                                text: label,
                              ))
                          .toList(),
                    )),
              ),
            ),
          ];
        },
        body: _buildBody(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Global.prefs.setStringList(Constant.SEARCH_HISTORY_KEY, historyData);
  }
}
