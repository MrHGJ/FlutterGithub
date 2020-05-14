import 'package:flutter/material.dart';

Widget numberAndText(num count, String text) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        count.toString(),
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
      Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.black38),
      ),
    ],
  );
}

Widget languageWithPoint(String language) {
  Color pointColor = Colors.orange;
  if (language == null || language.length == 0) {
    return Container(
      width: 0,
      height: 0,
    );
  }
  switch (language) {
    case "Java":
      pointColor = Colors.green;
      break;
    case "Dart":
      pointColor = Colors.red;
      break;
    case "JavaScript":
      pointColor = Colors.blue;
      break;
    case "HTML":
      pointColor = Colors.yellow;
      break;
    case "Python":
      pointColor = Colors.redAccent;
      break;
    case "C++":
      pointColor = Colors.purple;
      break;
    case "C#":
      pointColor = Colors.pink;
      break;
    case "PHP":
      pointColor = Colors.lightGreen;
      break;
    case "C":
      pointColor = Colors.purpleAccent;
      break;
    case "Ruby":
      pointColor = Colors.blueAccent;
      break;
    case "Go":
      pointColor = Colors.lightBlueAccent;
      break;
    case "Vue":
      pointColor = Colors.teal;
      break;
  }
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(
          Icons.fiber_manual_record,
          color: pointColor,
          size: 10,
        ),
      ),
      Text(
        language,
        style: TextStyle(color: Colors.black45),
      ),
    ],
  );
}

Widget infoWithIcon(message, icon,iconSize) {
  if(message==null||message.length==0){
    message="目前什么都没有";
  }
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: Icon(
          icon,
          color: Colors.white70,
          size: iconSize,
        ),
      ),
      Text(
        message ?? "目前什么都没有",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 13
        ),
      ),
    ],
  );
}
