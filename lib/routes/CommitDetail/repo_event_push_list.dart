import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/CommitDetail/commit_detail_page.dart';
import 'package:fluttergithub/widgets/myWidgets/index.dart';

class EventPushListPage extends StatefulWidget {
  EventPushListPage(this.repoOwner, this.repoName, this.payload);

  final String repoOwner;
  final String repoName;
  final EventPayloadBean payload;

  @override
  State<StatefulWidget> createState() {
    return _EventPushListPageState();
  }
}

class _EventPushListPageState extends State<EventPushListPage> {
  @override
  Widget build(BuildContext context) {
    var branch = widget.payload.ref.substring(11);
    return Scaffold(
      appBar: AppBar(
        title: Text('PushEvent List'),
      ),
      body: ListView.builder(
        itemCount: widget.payload.commits.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: MyCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.payload.commits[index].author.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.bookmark,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                      ),
                      Text(
                        widget.payload.commits[index].sha.substring(0, 7),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      widget.payload.commits[index].message,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              goToPage(
                  context: context,
                  page: CommitDetailPage(widget.repoOwner, widget.repoName,
                      widget.payload.commits[index].sha, branch));
            },
          );
        },
      ),
    );
  }
}
