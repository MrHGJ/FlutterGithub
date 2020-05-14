// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cacheConfigBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheConfigBean _$CacheConfigBeanFromJson(Map<String, dynamic> json) {
  return CacheConfigBean()
    ..enable = json['enable'] as bool
    ..maxAge = json['maxAge'] as num
    ..maxCount = json['maxCount'] as num;
}

Map<String, dynamic> _$CacheConfigBeanToJson(CacheConfigBean instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'maxAge': instance.maxAge,
      'maxCount': instance.maxCount,
    };
