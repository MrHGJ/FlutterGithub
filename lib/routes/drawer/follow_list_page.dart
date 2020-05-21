import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/widgets/personDetail/follow_person_list.dart';

class FollowListPage extends StatefulWidget{
  FollowListPage(this.title,this.userName);
  final String userName;
  final String title;
@override
  State<StatefulWidget> createState() {
    return _FollowListPageStat();
  }
}
class _FollowListPageStat extends State<FollowListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PersonFollowList(personName: widget.userName,isFollowing: true,),
    );
  }
}