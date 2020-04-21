//import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:zlapp/utitl/sharedpreferencesHelp.dart';
import 'package:event_bus/event_bus.dart';
//app的初始化配置
//如路由 横竖屏
class Application{
  static Router router;

  //事件总线
  static EventBus eventBus;

  static SpUtil sp;
}