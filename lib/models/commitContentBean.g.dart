// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitContentBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitContentBean _$CommitContentBeanFromJson(Map<String, dynamic> json) {
  return CommitContentBean()
    ..committer = json['committer'] == null
        ? null
        : CommiterBean.fromJson(json['committer'] as Map<String, dynamic>)
    ..message = json['message'] as String
    ..comment_count = json['comment_count'] as num;
}

Map<String, dynamic> _$CommitContentBeanToJson(CommitContentBean instance) =>
    <String, dynamic>{
      'committer': instance.committer,
      'message': instance.message,
      'comment_count': instance.comment_count,
    };
