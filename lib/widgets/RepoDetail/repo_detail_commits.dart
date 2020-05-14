import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/RelativeDateUtil.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class CommitsList extends StatefulWidget {
  CommitsList(this._reposOwner, this._reposName);

  final String _reposOwner;
  final String _reposName;

  @override
  State<StatefulWidget> createState() {
    return _CommitsListState();
  }
}

class _CommitsListState extends State<CommitsList>
    with AutomaticKeepAliveClientMixin {
  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext mContext) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: InfiniteListView<CommitItemBean>(
        onRetrieveData:
            (int page, List<CommitItemBean> items, bool refresh) async {
          var data = await NetApi(context).getCommits(
            widget._reposOwner,
            widget._reposName,
            queryParameters: {
              'page': page,
              'page_size': 30,
            },
          );
          //把请求到的新数据添加到items中
          items.addAll(data);
          // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
          return data.length == 30;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return _commitItem(list[index], mContext);
        },
      ),
    );
  }
}

Widget _commitItem(CommitItemBean commitData, BuildContext context) {
  return MyCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.account_box,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),
            Expanded(
              child: Text(
                commitData.commit.committer.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                RelativeDateFormat.format(
                    DateTime.parse(commitData.commit.committer.date)),
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            commitData.commit.message ?? "",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ),
            Expanded(
              child: Text(
                commitData.sha.substring(0, 7),
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.message,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ),
            Text(
              commitData.commit.comment_count.toString(),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
