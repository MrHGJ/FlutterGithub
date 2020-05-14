import 'package:json_annotation/json_annotation.dart';

part 'fileBean.g.dart';

@JsonSerializable()
class FileBean {
    FileBean();

    String name;
    String path;
    String sha;
    num size;
    String url;
    String html_url;
    String git_url;
    String download_url;
    String type;
    
    factory FileBean.fromJson(Map<String,dynamic> json) => _$FileBeanFromJson(json);
    Map<String, dynamic> toJson() => _$FileBeanToJson(this);
}
