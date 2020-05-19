import 'package:json_annotation/json_annotation.dart';

part 'commitDetailFileBean.g.dart';

@JsonSerializable()
class CommitDetailFileBean {
    CommitDetailFileBean();

    String sha;
    String filename;
    String status;
    num additions;
    num deletions;
    num changes;
    String blob_url;
    String raw_url;
    String contents_url;
    String patch;
    
    factory CommitDetailFileBean.fromJson(Map<String,dynamic> json) => _$CommitDetailFileBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CommitDetailFileBeanToJson(this);
}
