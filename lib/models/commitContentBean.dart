import 'package:json_annotation/json_annotation.dart';
import "commiterBean.dart";
part 'commitContentBean.g.dart';

@JsonSerializable()
class CommitContentBean {
    CommitContentBean();

    CommiterBean committer;
    String message;
    num comment_count;
    
    factory CommitContentBean.fromJson(Map<String,dynamic> json) => _$CommitContentBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommitContentBeanToJson(this);
}
