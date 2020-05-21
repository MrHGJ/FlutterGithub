import 'package:json_annotation/json_annotation.dart';
import "commitContentBean.dart";
import "userBean.dart";
import "commitDetailStatsBean.dart";
import "commitDetailFileBean.dart";
part 'commitDetailBean.g.dart';

@JsonSerializable()
class CommitDetailBean {
    CommitDetailBean();

    String sha;
    String node_id;
    CommitContentBean commit;
    UserBean committer;
    CommitDetailStatsBean stats;
    List<CommitDetailFileBean> files;
    
    factory CommitDetailBean.fromJson(Map<String,dynamic> json) => _$CommitDetailBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommitDetailBeanToJson(this);
}
