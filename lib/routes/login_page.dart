import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergithub/common/Global.dart';
import 'package:fluttergithub/common/net/NetApi.dart';
import 'package:fluttergithub/common/util/CommonUtil.dart';
import 'package:fluttergithub/common/constant/constant.dart';
import 'package:fluttergithub/l10n/localization_intl.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:fluttergithub/routes/drawer/index.dart';
import 'package:fluttergithub/routes/home_page.dart';
import 'package:fluttergithub/states/UserModel.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // 自动填充上次登录的用户名和密码，填充后将焦点定位到密码输入框
    //_unameController.text = Global.profile.lastLogin;
    _unameController.text = Global.prefs.getString(Constant.USER_LOGIN_KEY);
    _pwdController.text = Global.prefs.getString(Constant.PASSWORD_KEY);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    _borderStyle(borderColor, borderWith) {
      return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWith));
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      //防止因键盘弹出造成bottom overlowed by X pixels
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: new ExactAssetImage('imgs/login_back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(162, 146, 199, 0.6),
              const Color.fromRGBO(51, 51, 63, 0.8),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: _formKey,
              autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 40),
                      child: Image(
                        height: 80,
                        image: AssetImage('imgs/github_login_ic.png'),
                      ),
                    ),
                    TextFormField(
                        controller: _unameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: gm.userName,
                          labelStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.white),
                          border: _borderStyle(Colors.white, 0.5),
                          enabledBorder: _borderStyle(Colors.white, 0.5),
                          focusedBorder: _borderStyle(Colors.white, 0.5),
                          focusedErrorBorder: _borderStyle(Colors.white, 0.5),
                          errorBorder: _borderStyle(Colors.white, 0.5),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        // 校验用户名（不能为空）
                        validator: (v) {
                          return v.trim().isNotEmpty
                              ? null
                              : gm.userNameRequired;
                        }),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 30),
                      child: TextFormField(
                        controller: _pwdController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: gm.password,
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(color: Colors.white),
                            border: _borderStyle(Colors.white, 0.5),
                            enabledBorder: _borderStyle(Colors.white, 0.5),
                            focusedBorder: _borderStyle(Colors.white, 0.5),
                            focusedErrorBorder: _borderStyle(Colors.white, 0.5),
                            errorBorder: _borderStyle(Colors.white, 0.5),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                pwdShow
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  pwdShow = !pwdShow;
                                });
                              },
                            )),
                        obscureText: !pwdShow,
                        //校验密码（不能为空）
                        validator: (v) {
                          return v.trim().isNotEmpty
                              ? null
                              : gm.passwordRequired;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      height: 80.0,
                      width: double.infinity,
                      child: GradientButton(
                        colors: [Colors.redAccent, Colors.red],
                        borderRadius: BorderRadius.circular(50),
                        child: Text(gm.login,
                            style: new TextStyle(
                                letterSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 20.0)),
                        onPressed: _onLogin,
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      UserBean user;
      try {
        user = await NetApi(context)
            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
        Global.prefs.setBool(Constant.IS_LOGIN_KEY, true);
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          showLongToast("国内Github网站不稳定，请尝试切换网络、翻墙，或者过一段时间再登录");
        }
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }
      if (user != null) {
        // 返回
        Navigator.of(context).pop();
        goToPage(context: context, page: HomeRoute());
      }
    }
  }
}
