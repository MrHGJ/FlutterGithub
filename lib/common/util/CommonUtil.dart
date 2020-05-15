import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black.withAlpha(158),
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLongToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black.withAlpha(158),
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

//获取屏幕宽
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//获取屏幕高
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//Base64加密
String encodeBase64(String data) {
  var content = utf8.encode(data);
  return base64Encode(content);
}

//Base64解密
String decodeBase64(String data) {
  return utf8.decode(base64Decode(data));
}

///判断文件是否是Image类型
const IMAGE_END = [".png", ".jpg", ".jpeg", ".gif", ".svg"];

isImageEnd(path) {
  bool image = false;
  for (String item in IMAGE_END) {
    if (path.indexOf(item) + item.length == path.length) {
      image = true;
    }
  }
  return image;
}

//计算文件大小
calculateFileSize(int fileByte) {
  if (fileByte < 1024) {
    return fileByte.toString() + " B";
  } else if (fileByte < 1024 * 1024) {
    return keepDecimal(fileByte / 1024) + " KB";
  } else if (fileByte < 1024 * 1024 * 1024) {
    return keepDecimal(fileByte / 1024 / 1024) + " M";
  } else {
    return keepDecimal(fileByte / 1024 / 1024 / 1024) + " G";
  }
}

//保留两位小数
keepDecimal(double data) {
  String str = data.toString();
  String decimal;
  if (str.contains('.')) {
    var arry = str.split('.');
    decimal = arry[1].toString();
    if (decimal.length > 2) {
      decimal = decimal.substring(0, 2);
    }
    return arry[0].toString() + '.' + decimal;
  } else {
    return str;
  }
}

///跳转页面
goToPage({@required BuildContext context, @required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
