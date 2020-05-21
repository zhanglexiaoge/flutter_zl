import 'package:flutter/material.dart';
import 'package:zlapp/_const/const.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zlapp/utitl/appSize.dart';
import 'package:zlapp/http/httpUtil.dart';
import 'package:zlapp/Page/Home/home_banner_model_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'mock/home_girder_model_entity.dart';
import 'mock/homeGirderJson.dart';
import 'mock/home_list_model_entity.dart';
import 'package:zlapp/utitl/application.dart';
import 'package:zlapp/Router/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  //保持状态
  bool get wantKeepAlive => true;
  List bannerList = [];
  List <HomeGirderModelEntity>girderList = [];
  List <HomeListModelEntity>productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBannerList();
    getGirderList();
    getProductList();
  }
 // 获取商品分类导航列表 
 Future getGirderList() async {
     await Future.delayed(Duration(milliseconds: 300));//等待300毫秒
       //延迟300毫秒
       List girderListjson = HomeJson().HomeGirder;
       List <HomeGirderModelEntity>girderListTemp = [];
       for (Map<String, dynamic> map in girderListjson) {
         HomeGirderModelEntity model = HomeGirderModelEntity.fromJson(map);
         girderListTemp.add(model);
       }
       setState(() {
         girderList.addAll(girderListTemp);
       });
 }
  // 获取商品列表
  Future getProductList() async {
    await Future.delayed(Duration(milliseconds: 300));//等待300毫秒
    //延迟300毫秒
    List productListjson = HomeJson().ProductListJson;
    List <HomeListModelEntity>productListTemp = [];
    for (Map<String, dynamic> map in productListjson) {
      HomeListModelEntity model = HomeListModelEntity.fromJson(map);
      productListTemp.add(model);
    }
    setState(() {
      productList.addAll(productListTemp);
    });
  }

  // 获取商品列表
  Future getBannerList() async {
    List banner = await httpUtils.getRequset(homeBanner,params: null);
    List bannerListTemp = [];
    for (Map<String, dynamic> map in banner){
      HomeBannerModelEntity model = HomeBannerModelEntity.fromJson(map);
      bannerListTemp.add(model);
    }
    setState(() {
      bannerList.addAll(bannerListTemp);
    });
  }
  

  @override
  void dispose() {
    super.dispose();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.color_76fc,
        centerTitle: true,
        elevation: 0,
        title: Text(
          '首页',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
      body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                    Container(
                      color: Colors.white,
                      height: AppSize.height(220),
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          HomeBannerModelEntity model = bannerList[index];
                          return CachedNetworkImage(
                            imageUrl: model.imagePath,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          );
                        },
                        itemCount: bannerList.length,
                        pagination: new SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                size: 6.0, activeSize: 6.0, color: Colors.grey)),
                        autoplay: true,
                      ),
                    ),
                  ])),
            ),
            bodyGrid(girderList),
            bodyProductList(productList),
            ],
      ),
    );
  }

  // 分类导航列表
  Widget bodyGrid(List<HomeGirderModelEntity> menu) => SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 0.9,
    ),
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      HomeGirderModelEntity girderModel =  menu[index];
      return InkWell(
        onTap: () {
          //
          if(girderModel.id == 8) {
            //跳转到所有分类
            Application.router.navigateTo(context, Routes.classificationPage,clearStack: true);
          }

        },
        child: NavList(
          name: girderModel.name,
          img: girderModel.url,
          id: girderModel.id,
        ),
      );
    }, childCount: girderList.length),
  );
  // 商品列表
  Widget bodyProductList(List<HomeListModelEntity> shop) => SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      childAspectRatio: 0.7,
    ),
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return ProductList(
        model: shop[index],
      );
    }, childCount: productList.length),
  );
}


class NavList extends StatelessWidget {
  final img;
  final name;
  final id;
  NavList({this.img, this.name, this.id});
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
                    CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.fill,
                    height:AppSize.height(60),
                    width:AppSize.height(60),
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Text(name),
            ],
          )
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {

  final HomeListModelEntity model;

  ProductList({this.model});
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: model.url,
              placeholder: (context, url) => new Icon(
                Icons.image,
                color: Colors.white,
                size: MediaQuery.of(context).size.width / 2 - 10,
              ),
              errorWidget: (context, url, error) => new Icon(
                Icons.image,
                color: Colors.white,
                size: MediaQuery.of(context).size.width / 2 - 10,
              ),
            ),
            Container(height: 5.0),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
            Row(
              children: <Widget>[
                Text(
                  "￥" + model.price.toString(),
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
              ],
            )
          ],
        ));
  }
}


