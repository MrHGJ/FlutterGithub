// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepoDaoBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoDaoBean _$RepoDaoBeanFromJson(Map<String, dynamic> json) {
  return RepoDaoBean()
    ..name = json['name'] as String
    ..full_name = json['full_name'] as String
    ..description = json['description'] as String
    ..language = json['language'] as String
    ..forks_count = json['forks_count'] as num
    ..stargazers_count = json['stargazers_count'] as num
    ..open_issues_count = json['open_issues_count'] as num
    ..login = json['login'] as String
    ..avatar_url = json['avatar_url'] as String
    ..look_time = json['look_time'] as String;
}

Map<String, dynamic> _$RepoDaoBeanToJson(RepoDaoBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'full_name': instance.full_name,
      'description': instance.description,
      'language': instance.language,
      'forks_count': instance.forks_count,
      'stargazers_count': instance.stargazers_count,
      'open_issues_count': instance.open_issues_count,
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'look_time': instance.look_time,
    };
