import 'package:json_annotation/json_annotation.dart';

part 'cacheConfigBean.g.dart';

@JsonSerializable()
class CacheConfigBean {
    CacheConfigBean();

    bool enable;
    num maxAge;
    num maxCount;
    
    factory CacheConfigBean.fromJson(Map<String,dynamic> json) => _$CacheConfigBeanFromJson(json);
    Map<String, dynamic> toJson() => _$CacheConfigBeanToJson(this);
}
