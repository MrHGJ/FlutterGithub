import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/TrendReposItem.dart';

class TrendReposRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendReposRouteState();
  }
}

class _TrendReposRouteState extends State<TrendReposRoute>
    with AutomaticKeepAliveClientMixin {
  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<TrendRepoBean>(
      onRetrieveData:
          (int page, List<TrendRepoBean> items, bool refresh) async {
        var data = await NetApi(context).getTrendingRepos("daily", "");
        items.addAll(data);
        return data.length == 20;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        return TrendReposItem(list[index]);
      },
    );
  }
}
