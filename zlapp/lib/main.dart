import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:zlapp/Router/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:zlapp/utitl/application.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:zlapp/Page/splashPage/splashPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zlapp/utitl/sharedpreferencesHelp.dart';
import 'package:event_bus/event_bus.dart';
import 'package:zlapp/_const/const.dart';
import 'package:zlapp/providers/themeDataProvider/themeDataProvider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Application.sp = await SpUtil.getInstance();
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  MyApp(){
    // 注册 fluro routes
    final Router router = Router();
    Routes.configureRoutes(router);
    // 设置环境变量 router
    Application.router = router;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int themeColor ; //默认工程主颜色
  bool isDarkMode;

  @override
  void initState() {
    themeColor = Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
    isDarkMode = Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
    super.initState();
    if(themeColor == null ){
      themeColor = 0xFF5676FC;//默认主题色
      //本地存储主题色
      Application.sp.putInt(SharedPreferencesKeys.THEME_COLOR_KEY,themeColor);
    }
    if(isDarkMode == null){
      isDarkMode = false;
      //本地存储是否是暗黑模式
      Application.sp.putBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY,isDarkMode);
    }
  }

  @override
  void dispose() {
    //销毁
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration (
//        OKToast为一般情况下,一个 flutter 应用应该只有一个 MaterialApp(或是 WidgetsApp/CupertinoApp),
//        这里包裹后,可以缓存 Context 到 内存中,后续在调用显示时,不用传入 BuildContext
      child: OKToast(
        child: MultiProvider(
          //全局监听
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) {
                return ThemeModel(themeColor,isDarkMode);
              },)
          ],
          child:Consumer<ThemeModel>(
                  builder: (context,themeModel,_){
                     return MaterialApp(
                            theme: getThemeData(themeModel),
                            home: SplashPage(),
                             /// 生成路由
                            onGenerateRoute: Application.router.generator,
                            supportedLocales: [
                              const Locale('zh', 'CH'),
                              const Locale('en', 'US')
                            ],
                           );
                     },
        ),
      )) ,
      headerBuilder: () => ClassicHeader(
        height: 45.0,
        releaseText: '松开手刷新',
        refreshingText: '刷新中',
        completeText: '刷新完成',
        failedText: '刷新失败',
        idleText: '下拉刷新',),
      footerBuilder:() => ClassicFooter(
        noDataText: "- 我是有底线的 -",
        loadingText: "- 加载中 -",
        failedText: "- 加载失败,请重试 -",
        canLoadingText: "- 松开加载 -",
        idleText: "- 上拉加载更多 -",) ,
      hideFooterWhenNotFull: true,
    );
  }

  ThemeData getThemeData(ThemeModel themeModel){
    return ThemeData(
        iconTheme: themeModel.isDarkMode ? null: IconThemeData(
          color: Color(themeModel.settingThemeColor),
          size: 35.0,
        ),
        platform: TargetPlatform.iOS,
        backgroundColor: themeModel.isDarkMode ? null: Colours.bg_color,
        errorColor: themeModel.isDarkMode ? Colours.dark_red : Colours.red,
        brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: themeModel.isDarkMode ? Colours.dark_app_main : Color(themeModel.settingThemeColor),
        accentColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours.accentColor_color,
        // Tab指示器颜色
        indicatorColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: themeModel.isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: themeModel.isDarkMode ? Colours.dark_material_bg : null,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: themeModel.isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text默认文字样式
          body1: themeModel.isDarkMode ? TextStyles.textDark : TextStyles.text,
          // 这里用于小文字样式
          subtitle: themeModel.isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: themeModel.isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          color: themeModel.isDarkMode ? Colours.dark_bg_color : Color(themeModel.settingThemeColor),
          brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: themeModel.isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        )
    );
  }
}
