import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergithub/common/LogUtil.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/models/repo.dart';
import 'package:fluttergithub/models/user.dart';

import 'Global.dart';
import 'constant/ignore.dart';

class NetApi {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  NetApi([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
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

  //GitHub API OAuth认证
  void passOAuth(String token) async {
    var urlOauth = Constant.BASE_URL + "/authorizations";
    final Map requestParams = {
      "scopes": ['user', 'repo'],
      "note": "admin_script",
      "client_id": Ignore.clientId,
      "client_secret": Ignore.clientSecret
    };
    _options.method = "post";
    _options.headers["Authorization"] = token;
    await dio.request(urlOauth,
        data: json.encode(requestParams), options: _options);
  }

  // 登录接口，登录成功后返回用户信息
  Future<User> login(String username, String pwd) async {
    String token = 'Basic ' + base64.encode(utf8.encode('$username:$pwd'));
    //存储用户名、密码、token到sp
    Global.prefs.setString(Constant.USER_NAME_KEY, username);
    Global.prefs.setString(Constant.PASSWORD_KEY, pwd);
    Global.prefs.setString(Constant.TOKEN_KEY, token);

    passOAuth(token);
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    //dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    //Global.netCache.cache.clear();
    //更新profile中的token信息
    Global.profile.token = token;

    var urlLogin = Constant.BASE_URL + "/users/$username";
    _options.method = "get";
    _options.headers["Authorization"] = token;
    var response = await dio.request(urlLogin, options: _options);
    return User.fromJson(response.data);
  }

  //获取用户项目列表
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    var token = Global.prefs.getString(Constant.TOKEN_KEY);
    var userName = Global.prefs.getString(Constant.USER_NAME_KEY);
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      //_options.extra.addAll({"refresh": true, "list": true});
    }
    _options.method = "get";
    _options.headers["Authorization"] = token;
    var r = await dio.request<List>(
      Constant.BASE_URL + "/users/$userName/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
