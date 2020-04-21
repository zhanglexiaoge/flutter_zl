import 'package:flutter/material.dart';
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  //保持状态
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('我的'),
    );
  }

}