import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';

class TestRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TestRouteState();
  }
}

class _TestRouteState extends State<TestRoute>{
  @override
  Widget build(BuildContext context) {
    ListView childListView = ListView.builder(
      itemCount: 10,
      //shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: SizedBox(
            width: 100.0,
            height: 50.0 + ((27 * index) % 15) * 3.14,
            child: Center(
              child: Text('$index'),
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return childListView;
        },
      ),
    );
  }
  getNetData()async{
    return await NetApi(context).getRepoDetail("MrHGJ", "FlutterGithub");
  }
}