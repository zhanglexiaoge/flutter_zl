import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'route_handles.dart';
import 'package:zlapp/utitl/404.dart';
class Routes {
  static var root = "/";
  static String tabbarpage = "/tabbarpage";
  static String login = "/login";
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return WidgetNotFound();
        });
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(tabbarpage, handler: tabbarHandler);
  }

}