
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
///loading样式
Widget MySpinkitFullScreen(){
  return Center(
    child:  new Center(
        child: new SpinKitCubeGrid(
            color: Colors.blue, size: 60.0,
        duration: Duration(milliseconds:1000 ),)
    ),
  );
}