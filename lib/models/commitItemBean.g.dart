// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitItemBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitItemBean _$CommitItemBeanFromJson(Map<String, dynamic> json) {
  return CommitItemBean()
    ..sha = json['sha'] as String
    ..commit = json['commit'] == null
        ? null
        : CommitContentBean.fromJson(json['commit'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommitItemBeanToJson(CommitItemBean instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'commit': instance.commit,
    };
