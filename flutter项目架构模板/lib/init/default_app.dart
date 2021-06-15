import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_moban/core/http/http.dart';
import 'package:flutter_moban/core/utils/toast.dart';
import 'package:flutter_moban/generated/i18n.dart';
import 'package:flutter_moban/router/route_map.dart';
import 'package:flutter_moban/utils/provider.dart';
import 'package:flutter_moban/utils/sputils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

//默认App的启动
class DefaultApp {
  //运行app
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();
    SPUtils.init()
        .then((value) => runApp(Store.init(ToastUtils.init(MyApp()))));
    initApp();
  }

  //程序初始化操作
  static void initApp() {
    XHttp.init();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppTheme, LocaleModel>(
        builder: (context, appTheme, localeModel, _) {
      return GetMaterialApp(
        title: 'Flutter Project',
        theme: ThemeData(
          primarySwatch: appTheme.themeColor,
          buttonColor: appTheme.themeColor,
        ),
        getPages: RouteMap.getPages,
        defaultTransition: Transition.rightToLeft,
        locale: localeModel.getLocale(),
        supportedLocales: I18n.delegate.supportedLocales,
        localizationsDelegates: [
          I18n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale _locale, Iterable<Locale> supportedLocales) {
          if (localeModel.getLocale() != null) {
            //如果已经选定语言，则不跟随系统
            return localeModel.getLocale();
          } else {
            //跟随系统
            if (I18n.delegate.isSupported(_locale)) {
              return _locale;
            }
            return supportedLocales.first;
          }
        },
      );
    });
  }
}
