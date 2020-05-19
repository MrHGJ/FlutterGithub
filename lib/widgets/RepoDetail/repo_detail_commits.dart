import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/common/util/ListViewUtil.dart';
import 'package:fluttergithub/common/util/RelativeDateUtil.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/CommitDetail/commit_detail_page.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class CommitsList extends StatefulWidget {
  CommitsList(this._reposOwner, this._reposName, this._branch);

  final String _reposOwner;
  final String _reposName;
  final String _branch;

  @override
  State<StatefulWidget> createState() {
    return _CommitsListState();
  }
}

class _CommitsListState extends State<CommitsList>
    with AutomaticKeepAliveClientMixin {
  var mBranch;

  //branch切换订阅事件
  var _branchSubscription;

  //手动触发列表刷新的key
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    mBranch = widget._branch;
    //订阅切换分支事件
    _branchSubscription = eventBus.on<BranchSwitchEvent>().listen((event) {
      var curBranch = event.curBranch;
      if (curBranch != mBranch) {
        setState(() {
          mBranch = curBranch;
          refreshIndicatorKey.currentState.show(); //更新文件列表
        });
      }
    });
  }

  @override
  Widget build(BuildContext mContext) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: MyInfiniteListView<CommitItemBean>(
        refreshKey: refreshIndicatorKey,
        onRetrieveData:
            (int page, List<CommitItemBean> items, bool refresh) async {
          var data = await NetApi(context).getCommits(
            widget._reposOwner,
            widget._reposName,
            branch: mBranch,
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

  @override
  void dispose() {
    super.dispose();
    //取消订阅事件
    _branchSubscription.cancel();
  }

  Widget _commitItem(CommitItemBean commitData, BuildContext context) {
    return InkWell(
      child: MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: myAvatar(
                    (commitData.committer != null &&
                            commitData.committer.login != null)
                        ? commitData.committer.avatar_url
                        : '',
                    width: 36.0,
                    height: 36.0,
                    borderRadius: BorderRadius.circular(36),
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
      ),
      onTap: () {
        goToPage(
            context: context,
            page: CommitDetailPage(widget._reposOwner, widget._reposName,
                commitData.sha, mBranch));
      },
    );
  }
}
