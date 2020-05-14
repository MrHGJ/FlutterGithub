import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodeDetailFullScreen extends StatelessWidget{
  CodeDetailFullScreen(this.data);
  final String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebView(
      initialUrl: data,
      javascriptMode: JavascriptMode.unrestricted,
    ),);
  }
}