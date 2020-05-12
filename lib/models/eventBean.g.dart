// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventBean _$EventBeanFromJson(Map<String, dynamic> json) {
  return EventBean()
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..actor = json['actor'] == null
        ? null
        : UserBean.fromJson(json['actor'] as Map<String, dynamic>)
    ..repo = json['repo'] == null
        ? null
        : RepoBean.fromJson(json['repo'] as Map<String, dynamic>)
    ..payload = json['payload'] == null
        ? null
        : EventPayloadBean.fromJson(json['payload'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..created_at = json['created_at'] as String;
}

Map<String, dynamic> _$EventBeanToJson(EventBean instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'payload': instance.payload,
      'public': instance.public,
      'created_at': instance.created_at,
    };
