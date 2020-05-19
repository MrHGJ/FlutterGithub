import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/res/styles.dart';

class TestRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TestRouteState();
  }
}

class _TestRouteState extends State<TestRoute>{
  String a= 'lib/common/constant/constant.dart';
  int b;
  List<String> outa;
  var path='';
  var name='';
  @override
  void initState() {
    b=a.indexOf('/');
    outa=a.split('/');
    if(a.length==1){
      path = a;
      name =a;
    }else{
      name = outa.last;
      for(int i=0;i<outa.length-1;i++){
        path =path+outa[i]+'/';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body:  Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(path),
            Text(name),
            Text(b.toString()),
          ],
        ),
      ),
    );
  }
}