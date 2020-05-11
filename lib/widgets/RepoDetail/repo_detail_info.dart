import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class DetailInfo extends StatelessWidget {
  DetailInfo(this._repoDetailData, this._readmeData);

  final RepoDetailBean _repoDetailData;
  final ReadmeBean _readmeData;

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    //先过滤所有的"\n"，然后再用base64解码，得到Readme原始内容
    String readmeRaw = decodeBase64(_readmeData.content.replaceAll("\n", ''));
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
                Text(
                  _repoDetailData.full_name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      numberAndText(_repoDetailData.open_issues, "Issues"),
                      numberAndText(
                          _repoDetailData.stargazers_count, "Stargazers"),
                      numberAndText(_repoDetailData.forks_count, "Forks"),
                      numberAndText(
                          _repoDetailData.subscribers_count, "Watchers"),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(_repoDetailData.description ?? ""),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${gm.language} : ${_repoDetailData.language ?? ""}       ${gm.size} : ${_repoDetailData.size} KB       创建时间 : ${_repoDetailData.created_at.substring(0, 10)}",
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
          MyCard(
              child: MarkdownBody(
            data: readmeRaw,
          )),
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Center(child: Text("———— 到底了 ————")),
          )
        ],
      ),
    );
  }
}
