import 'package:fluttergithub/common/constant/constant.dart';

class Api {
  //GitHub API OAuth认证
  static getAuthorizations() {
    return Constant.BASE_URL + "/authorizations";
  }

  //用户登录获取用户信息
  static getUser(String username) {
    return Constant.BASE_URL + "/users/$username";
  }

  //获取用户项目列表
  static getRepos(String userName) {
    return Constant.BASE_URL + "/users/$userName/repos";
  }

  //趋势项目
  static getTrendingRepos(String since, String language) {
    return "https://github-trending-api.now.sh/repositories?language=$language&since=$since";
  }

  //趋势用户
  static getTrendDevelopers(String since, String language) {
    return 'https://github-trending-api.now.sh/developers?language=$language&since=$since';
  }
}
