// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventPayloadBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPayloadBean _$EventPayloadBeanFromJson(Map<String, dynamic> json) {
  return EventPayloadBean()
    ..push_id = json['push_id'] as num
    ..size = json['size'] as num
    ..distinct_size = json['distinct_size'] as num
    ..ref = json['ref'] as String
    ..head = json['head'] as String
    ..before = json['before'] as String
    ..commits = (json['commits'] as List)
        ?.map((e) => e == null
            ? null
            : EventCommitBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ref_type = json['ref_type'] as String
    ..action = json['action'] as String;
}

Map<String, dynamic> _$EventPayloadBeanToJson(EventPayloadBean instance) =>
    <String, dynamic>{
      'push_id': instance.push_id,
      'size': instance.size,
      'distinct_size': instance.distinct_size,
      'ref': instance.ref,
      'head': instance.head,
      'before': instance.before,
      'commits': instance.commits,
      'ref_type': instance.ref_type,
      'action': instance.action,
    };
