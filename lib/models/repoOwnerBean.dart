import 'package:json_annotation/json_annotation.dart';

part 'repoOwnerBean.g.dart';

@JsonSerializable()
class RepoOwnerBean {
    RepoOwnerBean();

    String login;
    num id;
    String node_id;
    String avatar_url;
    String gravatar_id;
    String type;
    bool site_admin;
    
    factory RepoOwnerBean.fromJson(Map<String,dynamic> json) => _$RepoOwnerBeanFromJson(json);
    Map<String, dynamic> toJson() => _$RepoOwnerBeanToJson(this);
}
