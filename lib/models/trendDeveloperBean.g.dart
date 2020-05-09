// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendDeveloperBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendDeveloperBean _$TrendDeveloperBeanFromJson(Map<String, dynamic> json) {
  return TrendDeveloperBean()
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String
    ..avatar = json['avatar'] as String
    ..repo = json['repo'] == null
        ? null
        : TrendDevSubBean.fromJson(json['repo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TrendDeveloperBeanToJson(TrendDeveloperBean instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'url': instance.url,
      'avatar': instance.avatar,
      'repo': instance.repo,
    };
