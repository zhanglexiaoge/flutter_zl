import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:zlapp/Page/Login/loginPage.dart';
import 'package:zlapp/Page/splashPage/splashPage.dart';
import 'package:zlapp/Page/tabBar/tabBarPage.dart';

// splash 页面 广告页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SplashPage();
    });
// 登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return LoginView();
    });
// 跳转到主页
var tabbarHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TabBarPage();
    });