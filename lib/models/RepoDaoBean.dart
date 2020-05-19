import 'package:fluttergithub/models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RepoDaoBean.g.dart';

@JsonSerializable()
class RepoDaoBean {
  RepoDaoBean();

  String name;
  String full_name;
  String description;
  String language;
  num forks_count;
  num stargazers_count;
  num open_issues_count;
  String login;
  String avatar_url;
  String look_time;

  factory RepoDaoBean.fromJson(Map<String, dynamic> json) =>
      _$RepoDaoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RepoDaoBeanToJson(this);

  fromRepoDetailBean(RepoDetailBean repoDetail) {
    RepoDaoBean repoDao = new RepoDaoBean();
    repoDao.name = repoDetail.name;
    repoDao.full_name = repoDetail.full_name;
    repoDao.description = repoDetail.description;
    repoDao.language = repoDetail.language;
    repoDao.forks_count = repoDetail.forks_count;
    repoDao.stargazers_count = repoDetail.stargazers_count;
    repoDao.open_issues_count = repoDetail.open_issues_count;
    repoDao.login = repoDetail.owner.login;
    repoDao.avatar_url = repoDetail.owner.avatar_url;
    repoDao.look_time = DateTime.now().toString();
    return repoDao;
  }
}
