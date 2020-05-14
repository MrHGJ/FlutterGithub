// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileBean _$ProfileBeanFromJson(Map<String, dynamic> json) {
  return ProfileBean()
    ..user = json['user'] == null
        ? null
        : UserBean.fromJson(json['user'] as Map<String, dynamic>)
    ..token = json['token'] as String
    ..theme = json['theme'] as num
    ..cache = json['cache'] == null
        ? null
        : CacheConfigBean.fromJson(json['cache'] as Map<String, dynamic>)
    ..lastLogin = json['lastLogin'] as String
    ..locale = json['locale'] as String;
}

Map<String, dynamic> _$ProfileBeanToJson(ProfileBean instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'theme': instance.theme,
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale,
    };
