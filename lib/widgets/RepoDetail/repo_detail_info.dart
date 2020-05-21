import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/person_detail_page.dart';
import 'package:fluttergithub/widgets/RepoDetail/repo_stargazer_or_watcher.dart';
import 'package:fluttergithub/widgets/markdown/my_markdown_widget.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';
import 'package:fluttergithub/widgets/myWidgets/mySpinKit.dart';

class DetailInfo extends StatefulWidget {
  DetailInfo(this._repoDetailData, this._branch);

  final RepoDetailBean _repoDetailData;
  final String _branch;

  @override
  State<StatefulWidget> createState() {
    return _DetailInfoState();
  }
}

class _DetailInfoState extends State<DetailInfo>
    with AutomaticKeepAliveClientMixin {
  var mBranch;
  var _futureBuilderFuture;

  //branch切换订阅事件
  var _branchSubscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    mBranch = widget._branch;
    //订阅切换分支事件
    _branchSubscription = eventBus.on<BranchSwitchEvent>().listen((event) {
      var curBranch = event.curBranch;
      if (curBranch != mBranch) {
        setState(() {
          mBranch = curBranch;
          _futureBuilderFuture = _getReadmeData(); //更新readme信息
        });
      }
    });
    _futureBuilderFuture = _getReadmeData();
    super.initState();
  }

  Future _getReadmeData() async {
    return NetApi(context).getReadme(
        repoOwner: widget._repoDetailData.owner.login,
        repoName: widget._repoDetailData.name,
        branch: mBranch);
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    //去掉ListView的顶部空白。当ListView没有和AppBar一起使用时，头部会有一个padding
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        //禁止ListView滑动，解决与外层CustomScrollView的滑动冲突
        //physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        children: <Widget>[
          ///构建第一个卡片
          MyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          widget._repoDetailData.owner.login,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[400]),
                        ),
                      ),
                      onTap: () {
                        goToPage(
                            context: context,
                            page: PersonDetailPage(
                              name: widget._repoDetailData.owner.login,
                            ));
                      },
                    ),
                    Expanded(
                      child: Text(
                        '/' + widget._repoDetailData.name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    languageWithPoint(mBranch),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: numberAndText(
                            widget._repoDetailData.open_issues, "Issues"),
                        onTap: () {
                          showToast('开发中...');
                        },
                      ),
                      InkWell(
                        child: numberAndText(
                            widget._repoDetailData.stargazers_count,
                            "Stargazers"),
                        onTap: () {
                          goToPage(
                              context: context,
                              page: RepoStarOrWatcherList(
                                widget._repoDetailData.owner.login,
                                widget._repoDetailData.name,
                                isStargazer: true,
                              ));
                        },
                      ),
                      InkWell(
                        child: numberAndText(
                            widget._repoDetailData.forks_count, "Forks"),
                        onTap: () {
                          showToast('开发中...');
                        },
                      ),
                      InkWell(
                        child: numberAndText(
                            widget._repoDetailData.subscribers_count,
                            "Watchers"),
                        onTap: () {
                          goToPage(
                              context: context,
                              page: RepoStarOrWatcherList(
                                widget._repoDetailData.owner.login,
                                widget._repoDetailData.name,
                                isStargazer: false,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///构建第二个卡片
          MyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "简介",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(widget._repoDetailData.description ?? ""),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${gm.language} : ${widget._repoDetailData.language ?? ""}       ${gm.size} : ${widget._repoDetailData.size} KB       创建时间 : ${widget._repoDetailData.created_at.substring(0, 10)}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),

          ///构建第三个卡片
          FutureBuilder(
            future: _futureBuilderFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Container(
                    width: 0,
                    height: 0,
                  );
                } else {
                  // 请求成功，显示数据
                  //先过滤所有的"\n"，然后再用base64解码，得到Readme原始内容
                  String readmeRaw =
                      decodeBase64(snapshot.data.content.replaceAll("\n", ''));
                  return MyCard(
                      child: MyMarkdownWidget(
                    markdownData: readmeRaw,
                  ));
                }
              } else {
                // 请求未结束，显示loading
                return Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Center(child: Text("———— 到底了 ————")),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅事件
    _branchSubscription.cancel();
  }
}
