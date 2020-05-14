import 'package:flutter/material.dart';
import 'package:fluttergithub/common/gmAvatar.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';

class TrendDevelopersItem extends StatefulWidget {
  TrendDevelopersItem(this.trendDev) : super(key: ValueKey(trendDev));
  final TrendDeveloperBean trendDev;

  @override
  State<StatefulWidget> createState() {
    return _TrendDevelopersItemState();
  }
}

class _TrendDevelopersItemState extends State<TrendDevelopersItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: gmAvatar(
                        //项目owner头像
                        widget.trendDev.avatar,
                        width: 50.0,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.trendDev.name ?? "",style: TextStyle(
                          fontSize: 16
                        ),),
                        Text(
                          widget.trendDev.username,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    )),
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
                        widget.trendDev.repo.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: widget.trendDev.repo.description == null
                            ? Text(
                                GmLocalizations.of(context).noDescription,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700]),
                              )
                            : Text(
                                widget.trendDev.repo.description,
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
              //_buildBottom()
            ],
          ),
        ),
      ),
    );
  }
}
