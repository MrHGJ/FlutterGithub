import 'package:json_annotation/json_annotation.dart';
import "commitContentBean.dart";
import "userBean.dart";
part 'commitItemBean.g.dart';

@JsonSerializable()
class CommitItemBean {
    CommitItemBean();

    String sha;
    CommitContentBean commit;
    UserBean committer;
    
    factory CommitItemBean.fromJson(Map<String,dynamic> json) => _$CommitItemBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommitItemBeanToJson(this);
}
