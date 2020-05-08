// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..full_name = json['full_name'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>)
    ..parent = json['parent'] == null
        ? null
        : Repo.fromJson(json['parent'] as Map<String, dynamic>)
    ..private = json['private'] as bool
    ..description = json['description'] as String
    ..fork = json['fork'] as bool
    ..language = json['language'] as String
    ..forks_count = json['forks_count'] as num
    ..stargazers_count = json['stargazers_count'] as num
    ..size = json['size'] as num
    ..default_branch = json['default_branch'] as String
    ..open_issues_count = json['open_issues_count'] as num
    ..pushed_at = json['pushed_at'] as String
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..subscribers_count = json['subscribers_count'] as num
    ..license = json['license'] as Map<String, dynamic>;
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.full_name,
      'owner': instance.owner,
      'parent': instance.parent,
      'private': instance.private,
      'description': instance.description,
      'fork': instance.fork,
      'language': instance.language,
      'forks_count': instance.forks_count,
      'stargazers_count': instance.stargazers_count,
      'size': instance.size,
      'default_branch': instance.default_branch,
      'open_issues_count': instance.open_issues_count,
      'pushed_at': instance.pushed_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'subscribers_count': instance.subscribers_count,
      'license': instance.license,
    };
