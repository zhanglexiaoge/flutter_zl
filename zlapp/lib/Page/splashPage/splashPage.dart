import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:zlapp/utitl/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zlapp/_const/imagePath.dart';
import 'package:zlapp/utitl/imageUtitl.dart';
import 'package:zlapp/Router/routes.dart';
import 'package:zlapp/_const/sharedPreferencesKeys.dart';
import 'package:zlapp/Page/Login/user_model_entity.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  int _status = 0;
  List<String> _guideList = [ImageSplashPath.app_start_1, ImageSplashPath.app_start_2, ImageSplashPath.app_start_3];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!Application.sp.hasKey(SharedPreferencesKeys.FISRT_SplashPage)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
        precacheImage(ImageUtils.getAssetImage(ImageSplashPath.ad_url), context);
      }
      _initSplash();
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }
  void _initSplash()async {
      if (!Application.sp.hasKey(SharedPreferencesKeys.FISRT_SplashPage)) {
        Application.sp.putBool(SharedPreferencesKeys.FISRT_SplashPage, true);
        _initGuide();
      }else {
        await Future.delayed(Duration(milliseconds: 1500));//等待1500毫秒
        goPage();
      }
  }
 void goPage(){
     //判断是否登录
   if (!Application.sp.hasKey(SharedPreferencesKeys.USER_MODEL)) {
     Application.router.navigateTo(context, Routes.login, clearStack: true);
   }else {
     String log_info = Application.sp.getString(SharedPreferencesKeys.USER_MODEL);
     UserModelEntity _userModel = UserModelEntity.fromJson(json.decode(log_info));
     if (_userModel != null) {
       Application.router.navigateTo(context, Routes.tabbarpage,clearStack: true);
     }else {
       Application.router.navigateTo(context, Routes.login, clearStack: true);
     }
   }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: _status == 0 ?Swiper(
          key: const Key('adswiper'),
          itemCount: 1,
          loop: false,
          itemBuilder: (_, index) {
            return  Image.asset(
              ImageSplashPath.ad_url,
              key:  Key('ad_url'),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              /// 忽略图片语义
              excludeFromSemantics: true,
            );
          },
        ):
        Swiper(
          key: const Key('swiper'),
          itemCount: _guideList.length,
          loop: false,
          itemBuilder: (_, index) {
            return  Image.asset(
              _guideList[index],
              key:  Key(_guideList[index]),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              /// 忽略图片语义
              excludeFromSemantics: true,
            );
          },
          onTap: (index) {
            if (index == _guideList.length - 1) {
              goPage();
            }
          },
        )
    );
  }
}
