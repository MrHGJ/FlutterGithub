import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/TrendDevelopersItem.dart';
import 'package:fluttergithub/widgets/myWidgets/no_data_or_no_net.dart';

class TrendDevelopersRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendDevelopersRouteState();
  }
}

class _TrendDevelopersRouteState extends State<TrendDevelopersRoute>
    with AutomaticKeepAliveClientMixin {
  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<TrendDeveloperBean>(
      emptyBuilder: (VoidCallback refresh, BuildContext context){
        return listNoDataView(refresh, context);
      },
      onRetrieveData:
          (int page, List<TrendDeveloperBean> items, bool refresh) async {
        var data = await NetApi(context).getTrendingDevelopers("daily", "");
        items.addAll(data);
        return data.length == 20;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        return TrendDevelopersItem(list[index]);
      },
    );
  }
}
