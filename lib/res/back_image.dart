import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithub/res/styles.dart';

///项目详情页头部背景图片，为了适应主题色
Widget getBackImage(BuildContext context){
  Color primaryColor= Theme.of(context).primaryColor;
  int index=0;
  List<String> imgPath = [
    'imgs/repo_back0.gif',
    'imgs/repo_back1.jpeg',
    'imgs/repo_back2.jpeg',
    'imgs/repo_back3.jpeg',
    'imgs/repo_back4.jpg',
    'imgs/repo_back5.jpeg',
  ];
  if(primaryColor==MyColors.themesSwatch[0]){

  }
  for(int i =0;i<MyColors.themesSwatch.length;i++){
    if(primaryColor ==MyColors.themesSwatch[i]){
      index =i;
    }
  }
  return Image.asset(
    imgPath[index],
    fit: BoxFit.cover,
  );
}