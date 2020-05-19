import 'package:json_annotation/json_annotation.dart';

part 'commitDetailStatsBean.g.dart';

@JsonSerializable()
class CommitDetailStatsBean {
    CommitDetailStatsBean();

    num total;
    num additions;
    num deletions;
    
    factory CommitDetailStatsBean.fromJson(Map<String,dynamic> json) => _$CommitDetailStatsBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommitDetailStatsBeanToJson(this);
}
