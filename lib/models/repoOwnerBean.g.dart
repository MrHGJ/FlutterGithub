// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repoOwnerBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoOwnerBean _$RepoOwnerBeanFromJson(Map<String, dynamic> json) {
  return RepoOwnerBean()
    ..login = json['login'] as String
    ..id = json['id'] as num
    ..node_id = json['node_id'] as String
    ..avatar_url = json['avatar_url'] as String
    ..gravatar_id = json['gravatar_id'] as String
    ..type = json['type'] as String
    ..site_admin = json['site_admin'] as bool;
}

Map<String, dynamic> _$RepoOwnerBeanToJson(RepoOwnerBean instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.node_id,
      'avatar_url': instance.avatar_url,
      'gravatar_id': instance.gravatar_id,
      'type': instance.type,
      'site_admin': instance.site_admin,
    };
