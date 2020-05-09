import 'package:flutter/material.dart';
import 'package:zlapp/_const/const.dart';
import 'package:zlapp/utitl/appSize.dart';
import 'package:zlapp/Page/Shop/goods_model_entity.dart';
import 'package:zlapp/Page/Shop/shopMockJson.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  //保持状态
  bool get wantKeepAlive => true;
  final List<Tab> myTabs = <Tab>[
    Tab(text: '推荐'),
    Tab(text: '衣服'),
    Tab(text: '化妆品'),
    Tab(text: '潮鞋'),
    Tab(text: '医美'),
    Tab(text: '包包'),

  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.color_76fc,
        centerTitle: true,
        elevation: 0,
        title: Text(
          '商城',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
      body:Text(
        '首页',
        style: TextStyle(color: Colors.white,fontSize: 18),
      ),
    );
  }

}