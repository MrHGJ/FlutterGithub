import 'package:json_annotation/json_annotation.dart';

part 'userBean.g.dart';

@JsonSerializable()
class UserBean {
    UserBean();

    String login;
    String avatar_url;
    String type;
    String name;
    String company;
    String blog;
    String location;
    String email;
    bool hireable;
    String bio;
    num public_repos;
    num followers;
    num following;
    String created_at;
    String updated_at;
    num total_private_repos;
    num owned_private_repos;
    
    factory UserBean.fromJson(Map<String,dynamic> json) => _$UserBeanFromJson(json);
    Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}
