// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitDetailFileBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitDetailFileBean _$CommitDetailFileBeanFromJson(Map<String, dynamic> json) {
  return CommitDetailFileBean()
    ..sha = json['sha'] as String
    ..filename = json['filename'] as String
    ..status = json['status'] as String
    ..additions = json['additions'] as num
    ..deletions = json['deletions'] as num
    ..changes = json['changes'] as num
    ..blob_url = json['blob_url'] as String
    ..raw_url = json['raw_url'] as String
    ..contents_url = json['contents_url'] as String
    ..patch = json['patch'] as String;
}

Map<String, dynamic> _$CommitDetailFileBeanToJson(
        CommitDetailFileBean instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'filename': instance.filename,
      'status': instance.status,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'changes': instance.changes,
      'blob_url': instance.blob_url,
      'raw_url': instance.raw_url,
      'contents_url': instance.contents_url,
      'patch': instance.patch,
    };
