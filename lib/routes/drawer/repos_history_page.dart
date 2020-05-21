import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/common/util/ListViewUtil.dart';
import 'package:fluttergithub/common/util/RelativeDateUtil.dart';
import 'package:fluttergithub/db/dao/repo_history_dao.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/MyDrawer.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';
import 'package:fluttergithub/widgets/myWidgets/no_data_or_no_net.dart';

import '../person_detail_page.dart';
import '../repo_detail_page.dart';

class RepoHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RepoHistoryPageState();
  }
}

class _RepoHistoryPageState extends State<RepoHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('足迹'),
      ),
      drawer: MyDrawer(),
      body: MyInfiniteListView<RepoDaoBean>(
        onRetrieveData:
            (int page, List<RepoDaoBean> items, bool refresh) async {
          RepoHistoryDao dao = new RepoHistoryDao();
          var data = await dao.getRepoHistoryList();
          if (data == null || data.length == 0) {
            items = new List();
          } else {
            items.addAll(data);
          }
          return false;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return _repoHistoryItem(list, index);
        },
        emptyBuilder: (VoidCallback refresh, BuildContext context){
          return listNoDataView(refresh, context);
        },
      ),
    );
  }

  Widget _repoHistoryItem(List<RepoDaoBean> repoDaoList, int index) {
    var repoDao = repoDaoList[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (index > 0 &&
                RelativeDateFormat.format(DateTime.parse(repoDao.look_time)) ==
                    RelativeDateFormat.format(
                        DateTime.parse(repoDaoList[index - 1].look_time)))
            ? Container(
                width: 0,
                height: 0,
              )
            : Padding(
                padding: EdgeInsets.only(left: 16, top: 20),
                child: Text(RelativeDateFormat.format(
                    DateTime.parse(repoDao.look_time))),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(1.0, 1.0), //延伸的阴影，向右下偏移的距离
                      blurRadius: 3.0) //延伸距离,会有模糊效果
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: myAvatar(
                                //项目owner头像
                                repoDao.avatar_url,
                                width: 30.0,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onTap: () {
                              goToPage(
                                  context: context,
                                  page: PersonDetailPage(
                                    name: repoDao.login,
                                  ));
                            },
                          ),
                          Expanded(
                            child: Text(
                              repoDao.login,
                              textScaleFactor: .9,
                            ),
                          ),
                          languageWithPoint(repoDao.language),
                        ],
                      ),
                    ),
                    //构建项目标题和简介
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              repoDao.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 12),
                              child: repoDao.description == null
                                  ? Text(
                                      GmLocalizations.of(context).noDescription,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[700]),
                                    )
                                  : Text(
                                      repoDao.description,
                                      maxLines: 3,
                                      style: TextStyle(
                                        height: 1.15,
                                        color: Colors.blueGrey[700],
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ]),
                    ),
                    // 构建卡片底部信息
                    _buildBottom(repoDao)
                  ],
                ),
              ),
            ),
            onTap: () {
              goToPage(
                  context: context,
                  page: RepoDetailRoute(repoDao.login, repoDao.name));
            },
          ),
        ),
      ],
    );
  }

  // 构建卡片底部信息
  Widget _buildBottom(RepoDaoBean repoDao) {
    const paddingWidth = 15;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              Icon(Icons.star),
              Text(" " +
                  repoDao.stargazers_count.toString().padRight(paddingWidth)),
              Icon(MyIcons.fork),
              Text(" " + repoDao.forks_count.toString().padRight(paddingWidth)),

              Icon(Icons.info), //我们的自定义图标
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(repoDao.open_issues_count.toString()),
              ),
            ];

            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
