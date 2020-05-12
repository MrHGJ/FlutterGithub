import 'package:json_annotation/json_annotation.dart';

part 'commiterBean.g.dart';

@JsonSerializable()
class CommiterBean {
    CommiterBean();

    String name;
    String email;
    String date;
    
    factory CommiterBean.fromJson(Map<String,dynamic> json) => _$CommiterBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommiterBeanToJson(this);
}
