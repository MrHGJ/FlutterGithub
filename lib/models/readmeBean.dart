import 'package:json_annotation/json_annotation.dart';

part 'readmeBean.g.dart';

@JsonSerializable()
class ReadmeBean {
    ReadmeBean();

    String name;
    String path;
    String sha;
    num size;
    String url;
    String download_url;
    String type;
    String content;
    String encoding;
    
    factory ReadmeBean.fromJson(Map<String,dynamic> json) => _$ReadmeBeanFromJson(json);
    Map<String, dynamic> toJson() => _$ReadmeBeanToJson(this);
}
