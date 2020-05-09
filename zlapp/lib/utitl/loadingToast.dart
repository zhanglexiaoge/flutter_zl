import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

//弹框类
class LodingToast {

  ///展示toast 展示报错 或者提醒信息
  static void showToast({String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  ///展示loading dialog
  static void showLoading(BuildContext context, String loadingText) {
    //展示一个loading dialog
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return SpinKitFadingCircle(
            color: Color(0xFF666666),
          );
        });
  }

  ///隐藏loading dialog
  static void disMissLoadingDialog(bool isAddLoading, BuildContext context) {
    if (isAddLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

}