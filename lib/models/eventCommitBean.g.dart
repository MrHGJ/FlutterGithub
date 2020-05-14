// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventCommitBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCommitBean _$EventCommitBeanFromJson(Map<String, dynamic> json) {
  return EventCommitBean()
    ..sha = json['sha'] as String
    ..author = json['author'] == null
        ? null
        : UserBean.fromJson(json['author'] as Map<String, dynamic>)
    ..message = json['message'] as String
    ..distinct = json['distinct'] as bool
    ..url = json['url'] as String;
}

Map<String, dynamic> _$EventCommitBeanToJson(EventCommitBean instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'author': instance.author,
      'message': instance.message,
      'distinct': instance.distinct,
      'url': instance.url,
    };
