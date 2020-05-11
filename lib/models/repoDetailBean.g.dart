// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repoDetailBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoDetailBean _$RepoDetailBeanFromJson(Map<String, dynamic> json) {
  return RepoDetailBean()
    ..id = json['id'] as num
    ..node_id = json['node_id'] as String
    ..name = json['name'] as String
    ..full_name = json['full_name'] as String
    ..private = json['private'] as bool
    ..owner = json['owner'] == null
        ? null
        : RepoOwnerBean.fromJson(json['owner'] as Map<String, dynamic>)
    ..html_url = json['html_url'] as String
    ..description = json['description'] as String
    ..fork = json['fork'] as bool
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..pushed_at = json['pushed_at'] as String
    ..homepage = json['homepage'] as String
    ..size = json['size'] as num
    ..stargazers_count = json['stargazers_count'] as num
    ..watchers_count = json['watchers_count'] as num
    ..language = json['language'] as String
    ..has_issues = json['has_issues'] as bool
    ..has_projects = json['has_projects'] as bool
    ..has_downloads = json['has_downloads'] as bool
    ..has_wiki = json['has_wiki'] as bool
    ..has_pages = json['has_pages'] as bool
    ..forks_count = json['forks_count'] as num
    ..archived = json['archived'] as bool
    ..disabled = json['disabled'] as bool
    ..open_issues_count = json['open_issues_count'] as num
    ..forks = json['forks'] as num
    ..open_issues = json['open_issues'] as num
    ..watchers = json['watchers'] as num
    ..default_branch = json['default_branch'] as String
    ..network_count = json['network_count'] as num
    ..subscribers_count = json['subscribers_count'] as num;
}

Map<String, dynamic> _$RepoDetailBeanToJson(RepoDetailBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.node_id,
      'name': instance.name,
      'full_name': instance.full_name,
      'private': instance.private,
      'owner': instance.owner,
      'html_url': instance.html_url,
      'description': instance.description,
      'fork': instance.fork,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'pushed_at': instance.pushed_at,
      'homepage': instance.homepage,
      'size': instance.size,
      'stargazers_count': instance.stargazers_count,
      'watchers_count': instance.watchers_count,
      'language': instance.language,
      'has_issues': instance.has_issues,
      'has_projects': instance.has_projects,
      'has_downloads': instance.has_downloads,
      'has_wiki': instance.has_wiki,
      'has_pages': instance.has_pages,
      'forks_count': instance.forks_count,
      'archived': instance.archived,
      'disabled': instance.disabled,
      'open_issues_count': instance.open_issues_count,
      'forks': instance.forks,
      'open_issues': instance.open_issues,
      'watchers': instance.watchers,
      'default_branch': instance.default_branch,
      'network_count': instance.network_count,
      'subscribers_count': instance.subscribers_count,
    };
