import 'package:json_annotation/json_annotation.dart';
import "userBean.dart";
import "cacheConfigBean.dart";
part 'profileBean.g.dart';

@JsonSerializable()
class ProfileBean {
    ProfileBean();

    UserBean user;
    String token;
    num theme;
    CacheConfigBean cache;
    String lastLogin;
    String locale;
    
    factory ProfileBean.fromJson(Map<String,dynamic> json) => _$ProfileBeanFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileBeanToJson(this);
}
