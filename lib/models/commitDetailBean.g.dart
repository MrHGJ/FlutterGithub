// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitDetailBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitDetailBean _$CommitDetailBeanFromJson(Map<String, dynamic> json) {
  return CommitDetailBean()
    ..sha = json['sha'] as String
    ..node_id = json['node_id'] as String
    ..commit = json['commit'] == null
        ? null
        : CommitContentBean.fromJson(json['commit'] as Map<String, dynamic>)
    ..committer = json['committer'] == null
        ? null
        : UserBean.fromJson(json['committer'] as Map<String, dynamic>)
    ..stats = json['stats'] == null
        ? null
        : CommitDetailStatsBean.fromJson(json['stats'] as Map<String, dynamic>)
    ..files = (json['files'] as List)
        ?.map((e) => e == null
            ? null
            : CommitDetailFileBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommitDetailBeanToJson(CommitDetailBean instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'node_id': instance.node_id,
      'commit': instance.commit,
      'committer': instance.committer,
      'stats': instance.stats,
      'files': instance.files,
    };
