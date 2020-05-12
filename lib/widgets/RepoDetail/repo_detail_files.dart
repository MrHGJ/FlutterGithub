import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';

class FileList extends StatefulWidget {
  FileList(this._reposOwner, this._reposName);

  final String _reposOwner;
  final String _reposName;

  @override
  State<StatefulWidget> createState() {
    return _FileListState();
  }
}

class _FileListState extends State<FileList>
    with AutomaticKeepAliveClientMixin {
  String path = "/android";

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext mContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              FlatButton(
                child: Text(
                  " bbbbbbbbB",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  LogUtil.e("000");
                  setState(() {
                    path="";
                  });
                  LogUtil.e("object");},
              ),
              Text(
                path,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: InfiniteListView<FileBean>(
              onRetrieveData: (int page, List<FileBean> items, bool refresh) async {
                var data = await NetApi(context).getReposContent(
                  widget._reposOwner,
                  widget._reposName,
                  path,
                  queryParameters: {
                    'page': page,
                    'page_size': 30,
                  },
                );
                //把请求到的新数据添加到items中
                items.addAll(data);
                // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
                return data.length == 30;
              },
              itemBuilder: (List list, int index, BuildContext ctx) {
                // 项目信息列表项
                return _fileItem(list[index], mContext);
              },
            ),
          ),
        )
      ],
    );
  }
}

Widget _fileItem(FileBean fileData, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: _fileIcon(fileData.type, context),
        ),
        Expanded(
          child: Text(
            fileData.name,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
        Text(
          fileData.size.toString() + " B",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget _fileIcon(String type, BuildContext context) {
  if (type == "dir") {
    return Icon(
      Icons.folder,
      color: Theme.of(context).primaryColor,
      size: 30,
    );
  } else {
    return Icon(
      Icons.subject,
      color: Theme.of(context).primaryColor,
      size: 30,
    );
  }
}
