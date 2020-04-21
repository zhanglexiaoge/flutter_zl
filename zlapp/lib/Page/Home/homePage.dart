import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  //保持状态
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('首页'),
    );
  }

}