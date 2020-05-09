import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/widgets/TrendReposItem.dart';

class TrendReposRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InfiniteListView<TrendRepoBean>(
      onRetrieveData: (int page,List<TrendRepoBean>items,bool refresh)async{
        var data = await NetApi(context).getTrendingRepos("daily", "");
        items.addAll(data);
        return data.length==20;
      },
      itemBuilder: (List list,int index,BuildContext ctx){
        return TrendReposItem(list[index]);
      },
    );
  }
}