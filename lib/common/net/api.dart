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

  //获取项目详情
  static getRepoDetail(String repoOwner, String repoName) {
    return Constant.BASE_URL + "/repos/$repoOwner/$repoName";
  }

  //获取当前项目分支
  static getBranch(String repoOwner, String repoName) {
    return '${Constant.BASE_URL}/repos/$repoOwner/$repoName/branches';
  }

  //获取Readme.md内容
  static getReadme(String repoOwner, String repoName) {
    return "${Constant.BASE_URL}/repos/$repoOwner/$repoName/readme";
  }

  //获取commits列表
  static getRepoCommits(String repoOwner, String repoName) {
    return "${Constant.BASE_URL}/repos/$repoOwner/$repoName/commits";
  }

  //获取commits详情列表
  static getRepoCommitsDetail(String repoOwner, String repoName, String sha) {
    return "${Constant.BASE_URL}/repos/$repoOwner/$repoName/commits/$sha";
  }

  //获取项目动态列表
  static getRepoEvents(String repoOwner, String repoName) {
    return "${Constant.BASE_URL}/repos/$repoOwner/$repoName/events";
  }

  //获取仓库下路径的内容
  static getRepoContent(String repoOwner, String repoName, String path) {
    return "${Constant.BASE_URL}/repos/$repoOwner/$repoName/contents/$path";
  }

  //获取用户starred项目列表
  static getStarredRepos(String userName) {
    return "${Constant.BASE_URL}/users/$userName/starred";
  }

  //获取用户动态列表
  static getUserEvents(String userName) {
    return "${Constant.BASE_URL}/users/$userName/events";
  }

  //userName关注的人
  static getUserFollowing(userName) {
    return "${Constant.BASE_URL}/users/$userName/following?";
  }

  //关注userName的人（粉丝）
  static getUserFollower(userName) {
    return "${Constant.BASE_URL}/users/$userName/followers?";
  }

  ///搜索
  ///type: repositories(搜索仓库)，users(搜索用户)
  ///searchWords: 搜索的关键词
  ///sort: 排序的方式，例如Best Match, Most Stars...
  ///order ： desc(降序)， asc(升序)
  static search(type, searchWords, sort, order) {
    return "${Constant.BASE_URL}/search/$type?q=$searchWords&sort=$sort&order=$order";
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
