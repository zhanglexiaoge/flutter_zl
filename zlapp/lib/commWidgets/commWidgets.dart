import 'package:flutter/material.dart';
import 'package:zlapp/_const/const.dart';

class CommWidgets {
 //app通用状态栏
  static AppBar getCommonAppBar(BuildContext context, String title, {double fontSize, List<Widget> actions}) {
    if (title == null) {
      title = "";
    }
    return AppBar(
      backgroundColor: Colours.color_76fc,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        //点击返回
        onPressed: () {
          if (context != null) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize == null ? 18.0 : fontSize,
        ),
      ),
      //标题栏居中
      centerTitle: true,
      //右边的action 按钮
      actions: actions == null ? <Widget>[] : actions,
      //action 颜色
      //actionsIconTheme: IconThemeData(color: Colors.white),
    );
  }

}