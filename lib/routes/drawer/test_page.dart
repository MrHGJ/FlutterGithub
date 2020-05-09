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
    return Scaffold(
      appBar: AppBar(
        title: Text("测试页"),
      ),
      body: FutureBuilder(
            future: getNetData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            },
          ),
    );
  }
  getNetData()async{
    return await NetApi(context).getTrendingDevelopers('daily','');
  }
}