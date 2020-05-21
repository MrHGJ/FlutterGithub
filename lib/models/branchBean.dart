import 'package:json_annotation/json_annotation.dart';

part 'branchBean.g.dart';

@JsonSerializable()
class BranchBean {
    BranchBean();

    String name;
    bool protected;
    
    factory BranchBean.fromJson(Map<String,dynamic> json) => _$BranchBeanFromJson(json);
    Map<String, dynamic> toJson() => _$BranchBeanToJson(this);
}
