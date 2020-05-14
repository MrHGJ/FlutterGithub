// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commiterBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommiterBean _$CommiterBeanFromJson(Map<String, dynamic> json) {
  return CommiterBean()
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..date = json['date'] as String;
}

Map<String, dynamic> _$CommiterBeanToJson(CommiterBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
    };
