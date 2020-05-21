import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize{

  static init(BuildContext context){
    //设置允许缩放
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);
  }

  static height(value){
    return ScreenUtil().setHeight(value.toDouble());
  }

  static width(value){
    return ScreenUtil().setWidth(value.toDouble());
  }
  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  static fontSize(double fontSize) {
    return ScreenUtil().setWidth(fontSize.toDouble());
  }

}

class Screen{
  static double _w;
  static double _statusH;
  static double _h;


  static void init(BuildContext c){
    if(_w == null) {
      MediaQueryData mqd = MediaQuery.of(c);

      _w = mqd.size.width;
      _h = mqd.size.height;
      _statusH = mqd.padding.top;
    }
  }

  static double width(){
    if(_w != null){
      return _w;
    }
    return 0;
  }

  static double height(){
    if(_h != null){
      return _h;
    }
    return 0;
  }
  //减去状态栏高度
  static double heightNostatus(){
    if(_h != null && _statusH != null ){
      return _h - _statusH;
    }
    return 0;
  }

  ///
  /// 状态栏高度
  ///
  static double statusH(){
    if(_statusH != null){
      return _statusH;
    }
    return 0;
  }

}
