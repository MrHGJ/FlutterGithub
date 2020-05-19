import 'package:flutter/material.dart';
import 'package:fluttergithub/common/event/event_bus.dart';
import 'package:fluttergithub/common/icons.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/common/util/ListViewUtil.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/FileView/code_detail_web.dart';
import 'package:fluttergithub/routes/FileView/photo_view_page.dart';

class FileList extends StatefulWidget {
  FileList(this._reposOwner, this._reposName, this._branch);

  final String _reposOwner;
  final String _reposName;
  final String _branch;

  @override
  State<StatefulWidget> createState() {
    return _FileListState();
  }
}

class _FileListState extends State<FileList>
    with AutomaticKeepAliveClientMixin<FileList> {
  String mBranch;
  String path = "";
  List<String> headerList = ["."]; //文件列表头部，保存当前的文件路径

  //branch切换订阅事件
  var _branchSubscription;

  //这个key用来在不是手动下拉，而是点击某个button或其它操作时，代码直接触发下拉刷新
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    mBranch = widget._branch;
    //订阅切换分支事件
    _branchSubscription = eventBus.on<BranchSwitchEvent>().listen((event) {
      var curBranch = event.curBranch;
      if (curBranch != mBranch) {
        setState(() {
          mBranch = curBranch;
          refreshIndicatorKey.currentState.show(); //更新文件列表
        });
      }
    });
    super.initState();
  }

  ///头部列表
  Widget _renderHeader(BuildContext context) {
    return Container(
      height: 40.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
          itemCount: headerList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return RawMaterialButton(
              constraints: new BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              padding: EdgeInsets.only(right: 1.0),
              onPressed: () {
                _resolveHeaderClick(index);
              },
              child: Text(
                headerList[index] + " > ",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }),
    );
  }

  ///头部列表点击
  _resolveHeaderClick(index) {
    if (headerList[index] != ".") {
      List<String> newHeaderList = headerList.sublist(0, index + 1);
      String path = newHeaderList.sublist(1, newHeaderList.length).join("/");
      this.setState(() {
        this.path = path;
        headerList = newHeaderList;
      });
      refreshIndicatorKey.currentState.show();
    } else {
      setState(() {
        path = "";
        headerList = ["."];
      });
      refreshIndicatorKey.currentState.show();
    }
  }

  ///构建每个列表的内容
  Widget _fileItem(FileBean fileData, BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      child: Container(
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
            _fileSize(fileData),
          ],
        ),
      ),
      onTap: () {
        _resolveItemClick(fileData);
      },
    );
  }

  //文件大小dir不显示，file显示
  Widget _fileSize(FileBean fileData) {
    if (fileData.type == 'dir') {
      return Container(
        width: 0,
        height: 0,
      );
    } else {
      return Text(
        calculateFileSize(fileData.size),
        style: TextStyle(color: Colors.grey, fontSize: 15),
      );
    }
  }

  ///处理文件列表item点击事件
  _resolveItemClick(FileBean fileData) {
    if (fileData.type == 'dir') {
      this.setState(() {
        headerList.add(fileData.name);
      });
      String path = headerList.sublist(1, headerList.length).join("/");
      this.setState(() {
        this.path = path;
      });
      refreshIndicatorKey.currentState.show();
    } else {
      String filePath = headerList.sublist(1, headerList.length).join("/") +
          "/" +
          fileData.name;
      if (isImageEnd(fileData.name)) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhotoViewPage(fileData.html_url + "?raw=true")));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CodeDetailWeb(
                      repoOwner: widget._reposOwner,
                      repoName: widget._reposName,
                      title: fileData.name,
                      filePath: filePath,
                      branch: mBranch,
                    )));
      }
    }
  }

  /// 重写返回按键逻辑
  Future<bool> _dialogExitApp(BuildContext context) {
    if (headerList.length == 1) {
      return Future.value(true);
    } else {
      _resolveHeaderClick(headerList.length - 2);
      return Future.value(false);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext mContext) {
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _renderHeader(mContext),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: MyInfiniteListView<FileBean>(
                refreshKey: refreshIndicatorKey,
                onRetrieveData:
                    (int page, List<FileBean> items, bool refresh) async {
                  var netData = await NetApi(context).getReposContent(
                    widget._reposOwner,
                    widget._reposName,
                    path,
                    branch: mBranch,
                    queryParameters: {
                      'page': page,
                      'page_size': 30,
                    },
                  );

                  if (netData == null || netData.length <= 0) {
                    items = new List();
                    return false;
                  }
                  items.addAll(sortFileData(netData));
                  // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
                  return items.length == 30;
                },
                itemBuilder: (List list, int index, BuildContext ctx) {
                  // 项目信息列表项
                  return _fileItem(list[index], mContext);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅事件
    _branchSubscription.cancel();
  }
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
      MyIcons.file_text,
      color: Theme.of(context).primaryColor,
      size: 30,
    );
  }
}

///将文件中dir排在前，file排在后
List<FileBean> sortFileData(List<FileBean> rawData) {
  List<FileBean> sortData = new List();
  List<FileBean> dirs = [];
  List<FileBean> files = [];
  if (rawData == null || rawData.length <= 0) {
    return sortData;
  }
  for (int i = 0; i < rawData.length; i++) {
    if (rawData[i].type == 'file') {
      files.add(rawData[i]);
    } else {
      dirs.add(rawData[i]);
    }
  }
  //把请求到的新数据添加到items中,先添加dir后添加file
  sortData.addAll(dirs);
  sortData.addAll(files);
  return sortData;
}
