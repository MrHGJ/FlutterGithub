import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/html_utils.dart';
import 'package:fluttergithub/routes/FileView/code_detail_fullscreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodeDetailWeb extends StatefulWidget {
  CodeDetailWeb(
      {this.repoOwner,
      this.repoName,
      @required this.title,
      this.filePath,
      this.htmlData,
      this.branch});

  final String repoOwner;
  final String repoName;
  final String title;
  final String filePath;
  final String branch;
  final String htmlData;

  @override
  State<StatefulWidget> createState() {
    return _CodeDetailWebState();
  }
}

class _CodeDetailWebState extends State<CodeDetailWeb> {
  String codeData;

  Future<String> _getNetData() async {
    if (widget.htmlData != null) {
      return widget.htmlData;
    }
    var response = await NetApi(context).getReposCodeFileContent(
        widget.repoOwner, widget.repoName, widget.filePath,
        branch: widget.branch);
    String data = HtmlUtils.resolveHtmlFile(response, "java");
    String url = new Uri.dataFromString(data,
            mimeType: 'text/html', encoding: Encoding.getByName("utf-8"))
        .toString();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CodeDetailFullScreen(codeData)));
            },
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: _getNetData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              // 请求成功，显示数据
              codeData = snapshot.data;
              return WebView(
                initialUrl: snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
              );
            }
          } else {
            // 请求未结束，显示loading
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
