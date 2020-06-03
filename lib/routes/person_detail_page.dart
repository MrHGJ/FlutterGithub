import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/common/delegate/index.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/FileView/photo_view_page.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';
import 'package:fluttergithub/widgets/myWidgets/mySpinKit.dart';
import 'package:fluttergithub/widgets/personDetail/follow_person_list.dart';
import 'package:fluttergithub/widgets/personDetail/person_event_list.dart';
import 'package:fluttergithub/widgets/personDetail/repo_list.dart';
import 'package:transparent_image/transparent_image.dart';

class PersonDetailPage extends StatefulWidget {
  PersonDetailPage({@required this.name});

  final String name;

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailState();
  }
}

class _PersonDetailState extends State<PersonDetailPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool isFollow;
  var userLogin;

  ///防止FutureBuilder进行不必要的重绘
  var _futureBuilderFuture;
  TabController tabController;
  var statusBarHeight = MediaQueryData.fromWindow(window).padding.top;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    userLogin = Global.prefs.getString(Constant.USER_NAME_KEY);
    tabController = TabController(length: 5, vsync: this);
    _futureBuilderFuture = _getPersonDetailData();
  }

  ///个人详情页内容
  _personDetailWidget(UserBean personInfo) {
    var gm = GmLocalizations.of(context);
    var mTabs = <String>['仓库', "星标", "动态", "关注", "粉丝"];
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          //一个状态栏大小的背景，防止上滑后TabBar一部分显示在状态栏中
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: statusBarHeight,
              maxHeight: statusBarHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          //卡片中的内容
          SliverPersistentHeader(
            pinned: false,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 200,
              maxHeight: 200,
              //图片蒙层背景的实现
              child: Stack(
                children: <Widget>[
                  //图片加载loading
                  Center(child: new CircularProgressIndicator()),
                  //第一层是背景图
                  Container(
                    width: double.infinity,
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: personInfo.avatar_url,
                        fit: BoxFit.cover),
                  ),
                  //第二层是当前主题色的半透明处理
                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: double.infinity,
                  ),
                  //第三层是对前两层背景做高斯模糊处理，然后显示上面的内容
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: _headPersonInfo(personInfo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //tab栏
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 50,
              maxHeight: 50,
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: TabBar(
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 15.0),
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.greenAccent,
                    controller: tabController,
                    tabs: mTabs
                        .map((String label) => Tab(
                              text: label,
                            ))
                        .toList(),
                  )),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          RepoListPage(
            personName: widget.name,
            isStarredRepoList: false,
          ),
          RepoListPage(
            personName: widget.name,
            isStarredRepoList: true,
          ),
          PersonEventList(username: widget.name),
          PersonFollowList(
            personName: widget.name,
            isFollowing: true,
          ),
          PersonFollowList(
            personName: widget.name,
            isFollowing: false,
          ),
        ],
      ),
    );
  }

  _headPersonInfo(UserBean personData) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: myAvatar(personData.avatar_url,
                      width: 80, borderRadius: BorderRadius.circular(80.0)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoViewPage(personData.avatar_url),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          personData.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        infoWithIcon(
                            personData.location, Icons.location_on, 15.0),
                        infoWithIcon(personData.company, Icons.business, 15.0),
                        infoWithIcon(personData.blog, Icons.link, 15.0),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !(userLogin == personData.login),
                  child: InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            isFollow ? Icons.favorite : Icons.favorite_border,
                            color: isFollow ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          isFollow ? 'Followed' : 'UnFollowed',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                    onTap: () {
                      _followOrUnFollow();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              personData.name ?? "",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "创建于：" + personData.created_at.substring(0, 10),
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              // 请求成功，显示数据
              return _personDetailWidget(snapshot.data);
            }
          } else {
            // 请求未结束，显示loading
            return MySpinkitFullScreen();
          }
        },
      ),
    );
  }

  Future _getPersonDetailData() async {
    //检查并设置是否follow
    int followedStatus =
        await NetApi(context).checkIsFollowing(developerName: widget.name);
    setState(() {
      isFollow = (followedStatus == 204);
    });
    return NetApi(context).getUserInfo(widget.name);
  }

  Future _followOrUnFollow() async {
    showLoading(context);
    int statusCode = await NetApi(context).followOrUnFollow(
        developerName: widget.name,
        isFollowed: isFollow);
    Navigator.of(context).pop();
    if (statusCode == 204) {
      if(isFollow){
        showToast('💔 UnFollowed Success');
      }else{
        showToast('❤️ Followed Success');
      }
      setState(() {
        isFollow = !isFollow;
      });
    } else {
      showToast('请求失败');
    }
  }
}
