import 'package:json_annotation/json_annotation.dart';
import "trendDevSubBean.dart";
part 'trendDeveloperBean.g.dart';

@JsonSerializable()
class TrendDeveloperBean {
    TrendDeveloperBean();

    String username;
    String name;
    String url;
    String avatar;
    TrendDevSubBean repo;
    
    factory TrendDeveloperBean.fromJson(Map<String,dynamic> json) => _$TrendDeveloperBeanFromJson(json);
    Map<String, dynamic> toJson() => _$TrendDeveloperBeanToJson(this);
}
