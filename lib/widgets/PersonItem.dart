import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/myAvatar.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/person_detail_page.dart';

import 'myWidgets/index.dart';

class PersonItem extends StatelessWidget {
  PersonItem({@required this.personData});

  final UserBean personData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MyCard(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: myAvatar(
                personData.avatar_url,
                width: 50.0,
                height: 50.0,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(
              personData.login,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(name: personData.login),
          ),
        );
      },
    );
  }
}
