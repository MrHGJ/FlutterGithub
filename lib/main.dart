import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/login_page.dart';
import 'package:provider/provider.dart';
import 'common/Global.dart';
import 'l10n/localization_intl.dart';
import 'routes/home_page.dart';
import 'routes/drawer/index.dart';
import 'states/index.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(notifier: ThemeModel()),
        ChangeNotifierProvider.value(notifier: UserModel()),
        ChangeNotifierProvider.value(notifier: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder:
          (BuildContext context, themeModel, localeModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(
              primaryColor: themeModel.theme,
              primaryColorDark: themeModel.theme),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: Provider.of<UserModel>(context).isLogin
              ? HomeRoute()
              : LoginRoute(),
          //应用主页
          locale: localeModel.getLocale(),
          //我们只支持美国英语和中文简体
          supportedLocales: [
            const Locale('en', 'US'), // 美国英语
            const Locale('zh', 'CN'), // 中文简体
            //其它Locales
          ],
          localizationsDelegates: [
            // 本地化的代理类
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationsDelegate()
          ],
          localeResolutionCallback:
              (Locale _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              //如果已经选定语言，则不跟随系统
              return localeModel.getLocale();
            } else {
              Locale locale;
              //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
              //则默认使用美国英语
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                locale = Locale('en', 'US');
              }
              return locale;
            }
          },
          // 注册命名路由表
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginRoute(),
            "themes": (context) => ThemeChangeRoute(),
            "language": (context) => LanguageRoute(),
            "test": (context) => TestRoute(),
            "trend": (context) => TrendRoute(),
          },
        );
      }),
    );
  }
}
