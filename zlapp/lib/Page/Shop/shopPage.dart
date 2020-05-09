import 'package:flutter/material.dart';
import 'package:zlapp/_const/const.dart';
import 'package:zlapp/utitl/appSize.dart';
import 'package:zlapp/Page/Shop/goods_model_entity.dart';
import 'package:zlapp/Page/Shop/shopMockJson.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with AutomaticKeepAliveClientMixin , SingleTickerProviderStateMixin{
  //保持状态
  bool get wantKeepAlive => true;
  TabController _tabController; //需要定义一个Controller
  List tabsTitie = ['精选','猜你喜欢','母婴','儿童','女装','百货','美食','美食'];
  List<FindingTabView> bodys = [];
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabsTitie.length, vsync: this);
    for (int i = 0; i < this.tabsTitie.length;i++){
      bodys.add(FindingTabView(i));
    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
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
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,//设置未选中时的字体颜色，tabs里面的字体样式优先级最高
          unselectedLabelStyle: TextStyle(fontSize: 20),
          labelColor: Colors.black,//设置选中时的字体颜色，tabs里面的字体样式优先级最高
          labelStyle: TextStyle(fontSize: 20.0),
          isScrollable: true,//允许左右滚动
          indicatorColor: Colors.red,//选中下划线的颜色
          indicatorSize: TabBarIndicatorSize.label,//选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
          indicatorWeight: 2.0,//选中下划线的高度，值越大高度越高，默认为2。0
          tabs: tabsTitie.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
         ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: bodys,
        ),
      );
  }
}


class FindingTabView extends StatefulWidget {
  final int currentPage;

  FindingTabView(this.currentPage);
  @override
  _FindingTabViewState createState() => _FindingTabViewState();
}

class _FindingTabViewState extends State<FindingTabView> with AutomaticKeepAliveClientMixin{
  List<GoodsModelEntity> goodsList = new List<GoodsModelEntity>();
  int page = 0;
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    _onLoading();
  }
  Future _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    goodsList.clear();
    page = 0;
    List girderListjson = ShopJson().goodsJson;
    if(mounted){
      setState(() {
        List girderListjson = ShopJson().goodsJson;
        for (Map<String, dynamic> map in girderListjson) {
          GoodsModelEntity model = GoodsModelEntity.fromJson(map);
          goodsList.add(model);
        }
      });
    }
    _refreshController.refreshCompleted(resetFooterState: true);
  }
  Future _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    page++;
    if(page <=1 ) {
      if(page == 0) {
        goodsList.clear();
        List girderListjson = ShopJson().goodsJson;
        if(mounted){
          setState(() {
            List girderListjson = ShopJson().goodsJson;
            for (Map<String, dynamic> map in girderListjson) {
              GoodsModelEntity model = GoodsModelEntity.fromJson(map);
              goodsList.add(model);
            }
          });
        }
      }else if(page == 1) {
        if(mounted){
          setState(() {
            List girderListjson = ShopJson().goodspage2Json;
            for (Map<String, dynamic> map in girderListjson) {
              GoodsModelEntity model = GoodsModelEntity.fromJson(map);
              goodsList.add(model);
            }
          });
        }
      }
      _refreshController.loadComplete();
    }else {
      _refreshController.loadNoData();
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: StaggeredGridView.countBuilder(
          primary: false,
          crossAxisCount: 4,
          itemCount: goodsList.length,
          itemBuilder: _buildCardItem,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 6.0,
        ),
      ),
    );
  }


  // 生成每项卡片
  Widget _buildCardItem(BuildContext context, int i){
    return InkWell(
      onTap: ()=>onItemClick(i),
      child: ThemeCard(
        title: goodsList[i].name,
        price: goodsList[i].price.toString(),
        imgUrl: goodsList[i].url,
        number: _randomBit(4).toString() + '人已付款',
      ),
    );
  }
  //点击每项卡片
  void onItemClick(int i){
    int id = goodsList[i].id;
    //Routes.instance.navigateTo(context, Routes.PRODUCT_DETAILS,id.toString());
  }
  //生成随机数
  _randomBit(int len) {
    String scopeF = '123456789';//首位
    String scopeC = '0123456789';//中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 1) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }
  @override
  bool get wantKeepAlive => true;
}

class ThemeCard extends StatelessWidget {
  final String title;
  final String price;
  final String number;
  final String imgUrl;

  ThemeCard({
    this.title,
    this.price,
    this.number,
    this.imgUrl
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(30)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              child:Image(image:CachedNetworkImageProvider(imgUrl),fit: BoxFit.cover,))
          ,
          Padding(
              child: Text(title,style: TextStyle(fontSize: AppSize.fontSize(40),color: Color(0xff333333)),
                maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price,style: TextStyle(fontSize: AppSize.fontSize(35),color: Color(0xffee4646)))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(number,style: TextStyle(fontSize: AppSize.fontSize(32),color: Color(0xff999999))))
        ],
      ),
    );
  }
}
