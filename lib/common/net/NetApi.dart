import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/models/index.dart';
import '../Global.dart';
import '../constant/ignore.dart';
import 'api.dart';

class NetApi {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  NetApi([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  //github OAuth认证需要，没有认证某些接口访问次数限制为60次/小时，认证后为5000次/小时
  final Map oAuthParams = {
    "scopes": ['user', 'repo'],
    "note": "admin_script",
    "client_id": Ignore.clientId,
    "client_secret": Ignore.clientSecret
  };
  static Dio dio = new Dio();

  static void init() {
    //添加缓存插件
    // dio.interceptors.add(Global.netCache);
    //设置用户token(可能为null，代表未登录)
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    //在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
//    if (!Global.isRelease) {
//      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//          (client) {
//        client.findProxy = (uri) {
//          return "PROXY 10.95.249.53:8888";
//        };
//        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
//        client.badCertificateCallback =
//            (X509Certificate cert, String host, int port) => true;
//      };
//    }
  }

  getAuthorization() async {
    String token = Global.prefs.get(Constant.TOKEN_KEY);
    if (token != null) {
      return token;
    } else {
      String basic = Global.prefs.get(Constant.BASIC_KEY);
      return basic;
    }
  }

  //GitHub API OAuth认证，获取token
  void passOAuth(String basic) async {
    var urlOauth = Api.getAuthorizations();
    _options.method = "post";
    _options.headers["Authorization"] = basic;
    var r = await dio.request(urlOauth,
        data: json.encode(oAuthParams), options: _options);
    if (r.data['token'] != null) {
      LogUtil.e(r.data['token']);
      //token : 89679626d7827c3fa52dbb3ca99d8a877a501b7e
      Global.prefs.setString(Constant.TOKEN_KEY, 'token ' + r.data['token']);
      //更新profile中的token信息
      Global.profile.token = r.data['token'];
    }
  }

  // 登录接口，登录成功后返回用户信息
  Future<UserBean> login(String username, String pwd) async {
    String basic = 'Basic ' + base64.encode(utf8.encode('$username:$pwd'));
    //存储用户名、密码、basic到sp
    Global.prefs.setString(Constant.USER_NAME_KEY, username);
    Global.prefs.setString(Constant.PASSWORD_KEY, pwd);
    Global.prefs.setString(Constant.BASIC_KEY, basic);

    passOAuth(basic);
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    //dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    //Global.netCache.cache.clear();
    //更新profile中的token信息
    //Global.profile.token = basic;

    var urlLogin = Api.getUser(username);
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    //Basic TXJIR0o6SGdqOTQwNjI3
    var response = await dio.request(urlLogin, options: _options);
    return UserBean.fromJson(response.data);
  }

  //获取用户项目列表
  Future<List<RepoBean>> getRepos(
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    var basic = Global.prefs.getString(Constant.BASIC_KEY);
    var userName = Global.prefs.getString(Constant.USER_NAME_KEY);
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      //_options.extra.addAll({"refresh": true, "list": true});
    }
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var url = Api.getRepos(userName);
    var r = await dio.request<List>(
      url,
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => RepoBean.fromJson(e)).toList();
  }

  //获取项目repo详情信息
  Future<RepoDetailBean> getRepoDetail(
      String repoOwner, String repoName) async {
    var url = Api.getRepoDetail(repoOwner, repoName);
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var response = await dio.request(url, options: _options);
    return RepoDetailBean.fromJson(response.data);
  }

  //获取readme
  Future<ReadmeBean> getReadme(String repoOwner, String repoName) async {
    var url = Api.getReadme(repoOwner, repoName);
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var response = await dio.request(url, options: _options);
    return ReadmeBean.fromJson(response.data);
  }

  //获取repo的commits列表
  Future<List<CommitItemBean>> getCommits(String repoOwner, String repoName,
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var url = Api.getRepoCommits(repoOwner, repoName);
    var r = await dio.request<List>(
      url,
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => CommitItemBean.fromJson(e)).toList();
  }

  //获取repo的activity列表
  Future<List<EventBean>> getEvents(String repoOwner, String repoName,
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var url = Api.getRepoEvents(repoOwner, repoName);
    var r = await dio.request<List>(
      url,
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => EventBean.fromJson(e)).toList();
  }

  //获取repo内容
  Future<List<FileBean>> getReposContent(
      String repoOwner, String repoName, String path,
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    _options.method = "get";
    _options.headers["Authorization"] = await getAuthorization();
    var url = Api.getRepoContent(repoOwner, repoName, path);
    var r = await dio.request<List>(
      url,
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => FileBean.fromJson(e)).toList();
  }

  //获取repo中代码内容
  Future<String> getReposCodeFileContent(
    String repoOwner,
    String repoName,
    String path,
  ) async {
    _options.method = "get";
    _options.headers["Accept"] = 'application/vnd.github.html';
    _options.headers["Authorization"] = await getAuthorization();
    var url = Api.getRepoContent(repoOwner, repoName, path);
    var r = await dio.request(
      url,
      options: _options,
    );
    return r.data;
  }

  //获取trending repos 项目排行榜
  Future<List<TrendRepoBean>> getTrendingRepos(
      String since, String language) async {
    var url = Api.getTrendingRepos(since, language);
    var response = await dio.get<List>(url);
    return response.data.map((item) => TrendRepoBean.fromJson(item)).toList();
  }

  //获取trending developers developer排行榜
  Future<List<TrendDeveloperBean>> getTrendingDevelopers(
      String since, String language) async {
    var url = Api.getTrendDevelopers(since, language);
    var response = await dio.get<List>(url);
    return response.data
        .map((item) => TrendDeveloperBean.fromJson(item))
        .toList();
  }
}
