import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  PhotoViewPage(this.picUrl);

  final String picUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("照片查看"),
      ),
      body: Container(
        color: Colors.black87,
        child: PhotoView(
          imageProvider: NetworkImage(picUrl),
          loadingChild: Container(
            child: new Stack(
              children: <Widget>[
                new Center(
                    child: new Image.asset('imgs/default_img.png',
                        height: 180.0, width: 180.0)),
                new Center(
                    child: new SpinKitFoldingCube(
                        color: Colors.white30, size: 60.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
