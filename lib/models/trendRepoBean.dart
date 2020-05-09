import 'package:json_annotation/json_annotation.dart';

part 'trendRepoBean.g.dart';

@JsonSerializable()
class TrendRepoBean {
    TrendRepoBean();

    String author;
    String name;
    String avatar;
    String url;
    String description;
    String language;
    String languageColor;
    num stars;
    num forks;
    num currentPeriodStars;
    List builtBy;
    
    factory TrendRepoBean.fromJson(Map<String,dynamic> json) => _$TrendRepoBeanFromJson(json);
    Map<String, dynamic> toJson() => _$TrendRepoBeanToJson(this);
}
