import 'package:json_annotation/json_annotation.dart';
import "repoOwnerBean.dart";
part 'repoDetailBean.g.dart';

@JsonSerializable()
class RepoDetailBean {
    RepoDetailBean();

    num id;
    String node_id;
    String name;
    String full_name;
    bool private;
    RepoOwnerBean owner;
    String html_url;
    String description;
    bool fork;
    String created_at;
    String updated_at;
    String pushed_at;
    String homepage;
    num size;
    num stargazers_count;
    num watchers_count;
    String language;
    bool has_issues;
    bool has_projects;
    bool has_downloads;
    bool has_wiki;
    bool has_pages;
    num forks_count;
    bool archived;
    bool disabled;
    num open_issues_count;
    num forks;
    num open_issues;
    num watchers;
    String default_branch;
    num network_count;
    num subscribers_count;
    
    factory RepoDetailBean.fromJson(Map<String,dynamic> json) => _$RepoDetailBeanFromJson(json);
    Map<String, dynamic> toJson() => _$RepoDetailBeanToJson(this);
}
