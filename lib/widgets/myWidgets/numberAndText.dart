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