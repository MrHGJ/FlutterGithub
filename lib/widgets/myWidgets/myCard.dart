import 'package:flutter/material.dart';

///自定义的卡片布局
class MyCard extends StatelessWidget {
  MyCard({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              offset: Offset(1.0, 1.0), //延伸的阴影，向右下偏移的距离
              blurRadius: 3.0) //延伸距离,会有模糊效果
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
        child: child,
      ),
    );
  }
}
