import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget listNoDataView(refresh, context) {
  return Material(
    //color: Colors.transparent,
    child: InkWell(
      splashColor: Theme.of(context).secondaryHeaderColor,
      onTap: refresh,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.event_busy,
                //color: Colors.deepOrange[300],
                color: Theme.of(context).primaryColor,
                size: 150,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "没有数据",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 22),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget listNoDataViewRefresh(refresh, context) {
  return Material(
    //color: Colors.transparent,
    child: InkWell(
      splashColor: Theme.of(context).secondaryHeaderColor,
      onTap: refresh,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.event_busy,
                //color: Colors.deepOrange[300],
                color: Theme.of(context).primaryColor,
                size: 150,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "没有数据",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 22),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

