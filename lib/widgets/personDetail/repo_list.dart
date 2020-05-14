import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/RepoItem.dart';

class RepoListPage extends StatefulWidget {
  RepoListPage({@required this.personName, @required this.isStarredRepoList});

  final String personName;
  final bool isStarredRepoList;

  @override
  State<StatefulWidget> createState() {
    return _RepoListPageState();
  }
}

class _RepoListPageState extends State<RepoListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: InfiniteListView<RepoBean>(
        onRetrieveData: (int page, List<RepoBean> items, bool refresh) async {
          var data;
          if (!widget.isStarredRepoList) {
            data = await NetApi(context).getRepos(
              repoOwner: widget.personName,
              refresh: refresh,
              queryParameters: {
                'page': page,
                'page_size': 20,
              },
            );
          } else {
            data = await NetApi(context).getStarredRepoList(
              userName: widget.personName,
              queryParameters: {
                'page': page,
                'page_size': 20,
              },
            );
          }
          //把请求到的新数据添加到items中
          items.addAll(data);
          // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
          return data.length == 20;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return RepoItem(list[index]);
        },
      ),
    );
  }
}

repoListWidget({BuildContext context, String userName}) {
  return InfiniteListView<RepoBean>(
    onRetrieveData: (int page, List<RepoBean> items, bool refresh) async {
      var data = await NetApi(context).getRepos(
        repoOwner: userName,
        refresh: refresh,
        queryParameters: {
          'page': page,
          'page_size': 20,
        },
      );
      //把请求到的新数据添加到items中
      items.addAll(data);
      // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
      return data.length == 20;
    },
    itemBuilder: (List list, int index, BuildContext ctx) {
      // 项目信息列表项
      return RepoItem(list[index]);
    },
  );
}
