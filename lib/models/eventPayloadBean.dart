import 'package:json_annotation/json_annotation.dart';
import "eventCommitBean.dart";
part 'eventPayloadBean.g.dart';

@JsonSerializable()
class EventPayloadBean {
    EventPayloadBean();

    num push_id;
    num size;
    num distinct_size;
    String ref;
    String head;
    String before;
    List<EventCommitBean> commits;
    String ref_type;
    String action;
    
    factory EventPayloadBean.fromJson(Map<String,dynamic> json) => _$EventPayloadBeanFromJson(json);
    Map<String, dynamic> toJson() => _$EventPayloadBeanToJson(this);
}
