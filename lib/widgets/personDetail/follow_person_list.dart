import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/person_detail_page.dart';
import 'package:fluttergithub/widgets/PersonItem.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class PersonFollowList extends StatefulWidget {
  PersonFollowList(
      {@required this.personName, @required this.isFollowing});

  final String personName;
  final bool isFollowing;

  @override
  State<StatefulWidget> createState() {
    return _PersonFollowListState();
  }
}

class _PersonFollowListState extends State<PersonFollowList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext mContext) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: InfiniteListView<UserBean>(
        onRetrieveData: (int page, List<UserBean> items, bool refresh) async {
          var data = await NetApi(context).getFollowList(
            userName: widget.personName,
            isGetFollowing: widget.isFollowing,
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
          return PersonItem(personData: list[index],);
        },
      ),
    );
  }
}


