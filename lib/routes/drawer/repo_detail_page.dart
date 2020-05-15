import 'package:common_utils/common_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/RepoDetail/index.dart';
import 'package:fluttergithub/widgets/myWidgets/mySpinKit.dart';

class RepoDetailRoute extends StatefulWidget {
  RepoDetailRoute(this.reposOwner, this.reposName);

  final String reposOwner;
  final String reposName;

  @override
  State<StatefulWidget> createState() {
    return _RepoDetailRouteState();
  }
}

class _RepoDetailRouteState extends State<RepoDetailRoute>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///当前的项目分支
  String curBranch;
  TabController tabController;

  ///防止FutureBuilder进行不必要的重绘
  var _futureBuilderFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //第一次进来默认展示master分支内容
    curBranch = 'master';
    tabController = TabController(length: 4, vsync: this);
    _futureBuilderFuture = _getRepoDetailData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              // 请求成功，显示数据
              return _repoDetailWidget(snapshot.data);
            }
          } else {
            // 请求未结束，显示loading
            return Center(
              child: MySpinkitFullScreen(),
            );
          }
        },
      ),
    );
  }

  Future _getRepoDetailData() async {
    return NetApi(context).getRepoDetail(widget.reposOwner, widget.reposName);
  }

  ///详情页内容
  Widget _repoDetailWidget(RepoDetailBean repoData) {
    var gm = GmLocalizations.of(context);
    var mTabs = <String>[gm.info, gm.file, gm.commit, gm.activity];
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(repoData.name),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 55.0, bottom: 62),
              collapseMode: CollapseMode.parallax,
              //视差效果
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
              background: Image.asset(
                'imgs/repo_back.gif',
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  MyIcons.fork,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showRepoBranchDialog();
                },
              )
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 15.0),
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.greenAccent,
              controller: tabController,
              tabs: mTabs
                  .map((String label) => Tab(
                        text: label,
                      ))
                  .toList(),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          DetailInfo(repoData, curBranch),
          FileList(widget.reposOwner, widget.reposName, curBranch),
          CommitsList(widget.reposOwner, widget.reposName, curBranch),
          EventList(widget.reposOwner, widget.reposName)
        ],
      ),
    );
  }

  ///弹出分支选择对话框
  Future<int> _showRepoBranchDialog() async {
    showLoading(context);
    List<BranchBean> branchList = await NetApi(context)
        .getRepoBranch(widget.reposOwner, widget.reposName);
    //关闭loading
    Navigator.pop(context);
    return showDialog<int>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("请选择分支："),
            children: branchList.map((branchData) {
              return SimpleDialogOption(
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    color: branchData.name == curBranch
                        ? Colors.grey[200]
                        : Colors.white,
                    child: Row(
                      children: <Widget>[
                        Icon(MyIcons.fork),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(branchData.name),
                        ),
                      ],
                    )),
                onPressed: () {
                  if (curBranch != branchData.name) {
                    showToast("已切换到 ${branchData.name} 分支");
                    setState(() {
                      curBranch = branchData.name;
                    });
                    //发送订阅事件
                    eventBus.fire(BranchSwitchEvent(branchData.name));
                  }
                  Navigator.pop(context);
                },
              );
            }).toList(),
          );
        });
  }
}
