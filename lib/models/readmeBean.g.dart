// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readmeBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadmeBean _$ReadmeBeanFromJson(Map<String, dynamic> json) {
  return ReadmeBean()
    ..name = json['name'] as String
    ..path = json['path'] as String
    ..sha = json['sha'] as String
    ..size = json['size'] as num
    ..url = json['url'] as String
    ..download_url = json['download_url'] as String
    ..type = json['type'] as String
    ..content = json['content'] as String
    ..encoding = json['encoding'] as String;
}

Map<String, dynamic> _$ReadmeBeanToJson(ReadmeBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'sha': instance.sha,
      'size': instance.size,
      'url': instance.url,
      'download_url': instance.download_url,
      'type': instance.type,
      'content': instance.content,
      'encoding': instance.encoding,
    };
