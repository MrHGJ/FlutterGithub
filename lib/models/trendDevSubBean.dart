import 'package:json_annotation/json_annotation.dart';

part 'trendDevSubBean.g.dart';

@JsonSerializable()
class TrendDevSubBean {
    TrendDevSubBean();

    String name;
    String description;
    String url;
    
    factory TrendDevSubBean.fromJson(Map<String,dynamic> json) => _$TrendDevSubBeanFromJson(json);
    Map<String, dynamic> toJson() => _$TrendDevSubBeanToJson(this);
}
