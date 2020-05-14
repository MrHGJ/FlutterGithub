import 'package:json_annotation/json_annotation.dart';
import "userBean.dart";
import "repoBean.dart";
import "eventPayloadBean.dart";
part 'eventBean.g.dart';

@JsonSerializable()
class EventBean {
    EventBean();

    String id;
    String type;
    UserBean actor;
    RepoBean repo;
    EventPayloadBean payload;
    bool public;
    String created_at;
    
    factory EventBean.fromJson(Map<String,dynamic> json) => _$EventBeanFromJson(json);
    Map<String, dynamic> toJson() => _$EventBeanToJson(this);
}
