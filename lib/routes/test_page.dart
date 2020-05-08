import 'package:flutter/material.dart';

class TestPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("测试页"),
      ),
      body: Text(
        "你可真厉害"
      ),
    );
  }
}