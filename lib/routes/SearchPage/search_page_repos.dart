import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/ListViewUtil.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/RepoItem.dart';

class SearchPageRepos extends StatefulWidget {
  SearchPageRepos({@required this.searchWords});

  final String searchWords;

  @override
  State<StatefulWidget> createState() {
    return _SearchPageReposState();
  }
}

class _SearchPageReposState extends State<SearchPageRepos>
    with AutomaticKeepAliveClientMixin {
  var curSearchWords;

  //搜索订阅事件
  var _searchChangeSubscription;

  //这个key用来在不是手动下拉，而是点击某个button或其它操作时，代码直接触发下拉刷新
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    curSearchWords = widget.searchWords;
    //订阅搜索事件
    _searchChangeSubscription = eventBus.on<SearchEvent>().listen((event) {
      setState(() {
        curSearchWords = event.searchWords;
      });
      refreshIndicatorKey.currentState.show(); //更新文件列表
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: MyInfiniteListView<RepoBean>(
        refreshKey: refreshIndicatorKey,
        onRetrieveData: (int page, List<RepoBean> items, bool refresh) async {
          var data = await NetApi(context).searchRepos(
            keyWords: curSearchWords,
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
          return RepoItem(list[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchChangeSubscription.cancel();
    super.dispose();
  }
}
