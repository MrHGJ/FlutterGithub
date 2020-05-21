import 'package:json_annotation/json_annotation.dart';
import "userBean.dart";
part 'repoBean.g.dart';

@JsonSerializable()
class RepoBean {
    RepoBean();

    num id;
    String name;
    String full_name;
    UserBean owner;
    RepoBean parent;
    bool private;
    String description;
    bool fork;
    String language;
    num forks_count;
    num stargazers_count;
    num size;
    String default_branch;
    num open_issues_count;
    String pushed_at;
    String created_at;
    String updated_at;
    num subscribers_count;
    
    factory RepoBean.fromJson(Map<String,dynamic> json) => _$RepoBeanFromJson(json);
    Map<String, dynamic> toJson() => _$RepoBeanToJson(this);
}
