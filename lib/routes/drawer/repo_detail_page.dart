import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/RepoDetail/index.dart';

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
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getRepoDetailData(),
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
              if (snapshot.data[0] is RepoDetailBean) {
                return _repoDetailWidget(snapshot.data[0], snapshot.data[1]);
              } else {
                return _repoDetailWidget(snapshot.data[1], snapshot.data[0]);
              }
            }
          } else {
            // 请求未结束，显示loading
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future _getRepoDetailData() async {
    return Future.wait([
      NetApi(context).getRepoDetail(widget.reposOwner, widget.reposName),
      NetApi(context).getReadme(widget.reposOwner, widget.reposName)
    ]);
  }

  ///详情页内容
  Widget _repoDetailWidget(RepoDetailBean repoData, ReadmeBean readmeData) {
    var gm = GmLocalizations.of(context);
    var mTabs = <String>[gm.info, gm.file, gm.commit, gm.activity];
    return CustomScrollView(
      slivers: <Widget>[
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
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              DetailInfo(repoData, readmeData),
              Center(
                child: Text('Content of Files'),
              ),
              Center(
                child: Text('Content of Commits'),
              ),
              Center(
                child: Text('Content of Activity'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
