import 'package:json_annotation/json_annotation.dart';
import "userBean.dart";
part 'eventCommitBean.g.dart';

@JsonSerializable()
class EventCommitBean {
    EventCommitBean();

    String sha;
    UserBean author;
    String message;
    bool distinct;
    String url;
    
    factory EventCommitBean.fromJson(Map<String,dynamic> json) => _$EventCommitBeanFromJson(json);
    Map<String, dynamic> toJson() => _$EventCommitBeanToJson(this);
}
