import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/res/icons.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/common/util/RelativeDateUtil.dart';
import 'package:fluttergithub/common/util/html_utils.dart';
import 'package:fluttergithub/models/commitDetailBean.dart';
import 'package:fluttergithub/models/commitDetailFileBean.dart';
import 'package:fluttergithub/res/styles.dart';
import 'package:fluttergithub/routes/FileView/code_detail_web.dart';
import 'package:fluttergithub/routes/FileView/photo_view_page.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';
import 'package:fluttergithub/widgets/myWidgets/mySpinKit.dart';

import '../person_detail_page.dart';

class CommitDetailPage extends StatefulWidget {
  CommitDetailPage(this.repoOwner, this.repoName, this.commitSha, this.branch);

  final String repoOwner;
  final String repoName;
  final String commitSha;
  final String branch;

  @override
  State<StatefulWidget> createState() {
    return _CommitDetailPageState();
  }
}

class _CommitDetailPageState extends State<CommitDetailPage> {
  ///防止FutureBuilder进行不必要的重绘
  var _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _getCommitDetailData();
  }

  Future _getCommitDetailData() async {
    return NetApi(context).getCommitsDetail(
        widget.repoOwner, widget.repoName, widget.commitSha,
        branch: widget.branch);
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
              return _buildCommitDetail(snapshot.data);
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

  //构建详情页
  Widget _buildCommitDetail(CommitDetailBean commitData) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverAppBar(),
        _buildHead(commitData),
        _buildSliverList(commitData.files)
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      title: Text('Commit ' + widget.commitSha.substring(0, 7)),
    );
  }

  Widget _buildHead(CommitDetailBean commitData) {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 20),
          color: Theme.of(context).primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  child: myAvatar(
                    //项目owner头像
                    (commitData.committer != null &&
                            commitData.committer.avatar_url != null)
                        ? commitData.committer.avatar_url
                        : '',
                    width: 65.0,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onTap: () {
                    if (commitData.committer != null &&
                        commitData.committer.login != null) {
                      goToPage(
                          context: context,
                          page: PersonDetailPage(
                            name: commitData.committer.login,
                          ));
                    } else if (commitData.commit.committer.name != null) {
                      goToPage(
                          context: context,
                          page: PersonDetailPage(
                            name: commitData.commit.committer.name,
                          ));
                    }
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: iconWithTextHorizontal(
                              icon: MyIcons.edit_square,
                              iconColor: Colors.white,
                              iconSize: 18.0,
                              text: commitData.files.length.toString(),
                              textColor: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: iconWithTextHorizontal(
                              icon: MyIcons.plus_square,
                              iconColor: Colors.white,
                              iconSize: 18.0,
                              text: commitData.stats.additions.toString(),
                              textColor: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: iconWithTextHorizontal(
                              icon: MyIcons.minus_square,
                              iconColor: Colors.white,
                              iconSize: 18.0,
                              text: commitData.stats.deletions.toString(),
                              textColor: Colors.white),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        RelativeDateFormat.format(
                            DateTime.parse(commitData.commit.committer.date)),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.0),
                      child: Text(
                        commitData.commit.message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _buildSliverList(List<CommitDetailFileBean> files) {
    List<String> pathList = new List(); //文件路径
    List<String> nameList = new List(); //文件名称
    //处理文件路径和文件名
    List<String> fileArray = new List();
    for (int j = 0; j < files.length; j++) {
      fileArray.clear();
      fileArray = files[j].filename.split('/');
      if (fileArray.length == 1) {
        pathList.add(files[j].filename);
        nameList.add(files[j].filename);
      } else {
        nameList.add(fileArray.last);
        String tmpPath = '';
        for (int i = 0; i < fileArray.length - 1; i++) {
          tmpPath = tmpPath + fileArray[i] + '/';
        }
        pathList.add(tmpPath);
      }
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => Container(
          margin: EdgeInsets.only(top: 10),
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildFilePath(pathList, index),
                MyCardNoMargin(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: _buildListHeadIcon(files[index].status),
                      ),
                      Expanded(
                        child: Text(
                          nameList[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          "+" + files[index].additions.toString(),
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ),
                      Text(
                        "-" + files[index].deletions.toString(),
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              if (isImageEnd(nameList[index])) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PhotoViewPage(files[index].raw_url)));
              } else {
                String html = HtmlUtils.generateCode2HTml(
                    HtmlUtils.parseDiffSource(files[index].patch, false),
                    backgroundColor: MyColors.webDraculaBackgroundColorString,
                    lang: '',
                    userBR: false);
                String htmlData = new Uri.dataFromString(html,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName("utf-8"))
                    .toString();
                goToPage(
                    context: context,
                    page: CodeDetailWeb(
                      title: nameList[index],
                      htmlData: htmlData,
                    ));
              }
            },
          ),
        ),
        childCount: files.length,
      ),
    );
  }

  Widget _buildFilePath(List<String> pathList, num index) {
    if (index > 0 && (pathList[index] == pathList[index - 1])) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: Text(
          pathList[index],
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }
  }

  Widget _buildListHeadIcon(String status) {
    if (status == 'added') {
      return Icon(
        MyIcons.plus_circle,
        color: Colors.green[700],
        size: 20,
      );
    } else if (status == 'removed') {
      return Icon(
        MyIcons.minus_circle,
        color: Colors.red[700],
        size: 20,
      );
    } else if (status == 'modified') {
      return Icon(
        MyIcons.modified_circle,
        color: Colors.yellow[700],
        size: 20,
      );
    } else {
      return Icon(
        MyIcons.renamed_circle,
        color: Colors.grey[700],
        size: 20,
      );
    }
  }
}
