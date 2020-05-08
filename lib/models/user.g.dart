// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..login = json['login'] as String
    ..avatar_url = json['avatar_url'] as String
    ..type = json['type'] as String
    ..name = json['name'] as String
    ..company = json['company'] as String
    ..blog = json['blog'] as String
    ..location = json['location'] as String
    ..email = json['email'] as String
    ..hireable = json['hireable'] as bool
    ..bio = json['bio'] as String
    ..public_repos = json['public_repos'] as num
    ..followers = json['followers'] as num
    ..following = json['following'] as num
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..total_private_repos = json['total_private_repos'] as num
    ..owned_private_repos = json['owned_private_repos'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.public_repos,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'total_private_repos': instance.total_private_repos,
      'owned_private_repos': instance.owned_private_repos,
    };
