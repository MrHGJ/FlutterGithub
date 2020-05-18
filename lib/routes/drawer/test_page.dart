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
  List<String>  historyData = [
    '但是减肥啊',
    '动机了',
    '附近的撒',
  ];
  Widget _buildHistoryItem(position){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        margin: EdgeInsets.only(right: 10),
        color: MyColors.miWhite,
        child: Center(
          child: Text(
            historyData[position],
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      onTap: () {

      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body:  GestureDetector(
        child:Container(
            padding: EdgeInsets.all( 30),

            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: historyData.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildHistoryItem(index);
              },
            )
        ) ,
        onTap: (){
          showToast("点了");
          setState(() {
            historyData.clear();
          });
        },
      )
    );
  }
}