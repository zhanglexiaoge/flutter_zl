import 'package:flutter/material.dart';
class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with AutomaticKeepAliveClientMixin {
  //保持状态
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('商城'),
    );
  }
}