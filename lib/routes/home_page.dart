import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/NetApi.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/repo.dart';
import 'package:fluttergithub/states/UserModel.dart';
import 'package:fluttergithub/widgets/MyDrawer.dart';
import 'package:fluttergithub/widgets/RepoItem.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations
            .of(context)
            .home),
      ),
      body: _buildBody(context),
      drawer: MyDrawer(),
    );
  }

}
//构建主页面
Widget _buildBody(context) {
  UserModel userModel = Provider.of<UserModel>(context);
  if (!userModel.isLogin) {
    //用户未登录，显示登录按钮
    return Center(
      child: RaisedButton(
        child: Text(GmLocalizations
            .of(context)
            .login),
        onPressed: () => Navigator.of(context).pushNamed("login"),
      ),
    );
  } else {
    //已登录，则展示项目列表
    return InfiniteListView<Repo>(
      onRetrieveData: (int page, List<Repo> items, bool refresh) async {
        var data = await NetApi(context).getRepos(
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
}