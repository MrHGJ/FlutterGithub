// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitDetailStatsBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitDetailStatsBean _$CommitDetailStatsBeanFromJson(
    Map<String, dynamic> json) {
  return CommitDetailStatsBean()
    ..total = json['total'] as num
    ..additions = json['additions'] as num
    ..deletions = json['deletions'] as num;
}

Map<String, dynamic> _$CommitDetailStatsBeanToJson(
        CommitDetailStatsBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'additions': instance.additions,
      'deletions': instance.deletions,
    };
