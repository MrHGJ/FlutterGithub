import 'package:flutter/material.dart';
import 'package:fluttergithub/common/gmAvatar.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/drawer/repo_detail_page.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class TrendReposItem extends StatefulWidget {
  TrendReposItem(this.trendRepo) : super(key: ValueKey(trendRepo));
  final TrendRepoBean trendRepo;

  @override
  State<StatefulWidget> createState() {
    return _TrendReposItemState();
  }
}

class _TrendReposItemState extends State<TrendReposItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: gmAvatar(
                          //项目owner头像
                          widget.trendRepo.avatar,
                          width: 30.0,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.trendRepo.author,
                          textScaleFactor: .9,
                        ),
                      ),
                      languageWithPoint(widget.trendRepo.language),
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
                          widget.trendRepo.name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 12),
                          child: widget.trendRepo.description == null
                              ? Text(
                                  GmLocalizations.of(context).noDescription,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[700]),
                                )
                              : Text(
                                  widget.trendRepo.description,
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
                _buildBottom()
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepoDetailRoute(
                  widget.trendRepo.author, widget.trendRepo.name),
            ),
          );
        },
      ),
    );
  }

  // 构建卡片底部信息
  Widget _buildBottom() {
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
                  widget.trendRepo.stars.toString().padRight(paddingWidth)),
              Icon(MyIcons.fork),
              Text(" " +
                  widget.trendRepo.forks.toString().padRight(paddingWidth)),

              Icon(Icons.stars), //我们的自定义图标
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(widget.trendRepo.currentPeriodStars.toString() +
                    " stars today"),
              ),
            ];

            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
