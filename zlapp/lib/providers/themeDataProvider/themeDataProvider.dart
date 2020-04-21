import 'package:flutter/material.dart';


///主题 model
class ThemeModel extends ChangeNotifier {
  int settingThemeColor;
  bool isDarkMode;
  ThemeModel(this.settingThemeColor,this.isDarkMode);

  void changeTheme (int themeColor,bool isDark){
    this.settingThemeColor = themeColor;
    this.isDarkMode = isDark;
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}