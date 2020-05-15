// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchBean _$BranchBeanFromJson(Map<String, dynamic> json) {
  return BranchBean()
    ..name = json['name'] as String
    ..protected = json['protected'] as bool;
}

Map<String, dynamic> _$BranchBeanToJson(BranchBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'protected': instance.protected,
    };
