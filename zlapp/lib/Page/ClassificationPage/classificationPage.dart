import 'package:flutter/material.dart';
import 'package:zlapp/_const/const.dart';
import 'calssMock.dart';
import 'calssifcation_model_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zlapp/utitl/appSize.dart';

class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  List<CalssifcationModelEntity> Listleft = [];
  List ListRight = [];
  var selctid = '1';
  ScrollController _scrollController = new ScrollController(); //监听左侧listView滚动位置
  @override
  void initState() {
    super.initState();
    _onLoading();
    _scrollController.addListener(() {   // 为控制器注册滚动监听方法
      //print(_scrollController.offset);
//      if (_controller.offset > 1000) {
//        // 如果 ListView 已经向下滚动了 1000，则开启 Top 按钮
//        setState(() {
//          isToTop = true;
//        });
//      } else if (_controller.offset < 300) {
//        // 如果 ListView 向下滚动距离不足 300，则禁用
//        setState(() {
//          isToTop = false;
//        });
//      }
    });
  }

  Future _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    List Listleftjson = ClassMockJson().allClass;
    if(mounted){
      setState(() {
        for (Map<String, dynamic> map in Listleftjson) {
          CalssifcationModelEntity model = CalssifcationModelEntity.fromJson(map);
          Listleft.add(model);
          if(ListRight.length == 0) {
            ListRight.addAll(model.rightGirder);
          }
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    //计算右侧GridView宽高比：
    var leftWidth = Screen.width() / 6;
    //右侧宽高=总宽度-左侧宽度-Gridview外层元素左右的Padding值-GridView中间的间距
    var rightItemWidth =
        (Screen.width() - leftWidth - 20 - 20) / 3;
    rightItemWidth = AppSize.width(rightItemWidth);
    var rightItemHeigth = rightItemWidth + AppSize.height(32);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colours.color_76fc,
          centerTitle: true,
          elevation: 0,
          title: Text(
            '商品分类',
            style: TextStyle(color: Colors.white,fontSize: AppSize.fontSize(40)),
          ),
        ),
        preferredSize: Size.fromHeight(44)),
    body: Container(
      color: Colours.color_f5f5,
      child:Row(

        children: <Widget>[
          _leftCateWidget(leftWidth),
          Expanded(
            child: _rightCateWidget(rightItemWidth, rightItemHeigth),
          ),

        ],
      ) ,
    ),
    );
  }

  //左侧组件
  Widget _leftCateWidget(leftWidth) {
    return Container(
      width: leftWidth,
      child: new ListView.builder(
          controller: _scrollController,
          itemCount: Listleft.length,
          itemBuilder: (BuildContext context, int position) {
               return getRow(position);
           }),
      );
  }

  Widget getRow(int i) {
    int index = i + 1;
    bool selctBool = (index.toString() == selctid);
    return new GestureDetector(
      child: new Container(
        decoration: BoxDecoration(
          color: selctBool ? Colours.color_f5f5 : Colours.color_ffff,
        ),
        height: 44,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //_leftCateWidget(20
              Container(
                padding: EdgeInsets.fromLTRB(1, 10, 0, 10),
                width: 3,
                height: 24,
                color: selctBool ? Colours.color_af45 : Colours.color_ffff,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: new Text(Listleft[i].name,
                      style: TextStyle(
                          color: selctBool ? Colours.color_af45 : Colours
                              .color_6666, fontSize: 16)),
                ),
              ),

            ]
        ),
      ),
      onTap: () {
        //判断item是否需要滚动
        if(_scrollController.offset <=0 ) {
          //item 高度  * index  > 屏幕高度的 0.5
          //真实屏幕高度
          double height = Screen.heightNostatus() - Size.fromHeight(44).height;

          if(44 * (i+ 1)  > Screen.height() * 0.5){
            //需要滑动到屏幕中心位置
            double offset=  44 * (i+ 1) - height * 0.5;
            _scrollController.animateTo(offset, duration: Duration(milliseconds: 200), curve: Curves.ease);
          }
        }else {
          if(i +1 > int.parse(selctid)){
            //需要滑动到屏幕中心位置
            // Listleft.length *44 - Screen.height() 最大偏移量

            //真实屏幕高度
            double height = Screen.heightNostatus() - Size.fromHeight(44).height;
            double maxOffset = Listleft.length *44 - height;
            double offset=  44 * (i+ 1) - height * 0.5 ;
            if(_scrollController.offset < maxOffset) {

              _scrollController.animateTo(offset, duration: Duration(milliseconds: 200), curve: Curves.ease);
            }
          }else if (i +1 < int.parse(selctid)){
            //真实屏幕高度
            double height = Screen.heightNostatus() - Size.fromHeight(44).height;
            double maxOffset = Listleft.length *44 - height;
            double selctOffset = (i +1) * 44.0 - height;
            double offset  = (i +1) * 44.0 - height * 0.5;
            double newoffset = maxOffset - selctOffset;
            double newoffsetcopy =  maxOffset - newoffset;
            if(offset >= 0) {
              print(offset);
              print('222222' + (height * 0.5).toString());
              print('3333333' + (_scrollController.offset).toString());
              if(_scrollController.offset == maxOffset && offset < height * 0.5) {
                _scrollController.animateTo(offset, duration: Duration(milliseconds: 200), curve: Curves.ease);
              }else if(_scrollController.offset < maxOffset && offset < height * 0.5) {
                _scrollController.animateTo(offset, duration: Duration(milliseconds: 200), curve: Curves.ease );
              }



            }else {
              if(_scrollController.offset > 0) {
                _scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.ease );
              }
            }
           // _scrollController.animateTo(newoffset, duration: Duration(milliseconds: 200), curve: Curves.easeInOut );

//            if(_scrollController.offset > 0) {
//              if(selctOffset <= 0) {
//                if(offset >= 0){
//                  double newoffset = maxOffset - selctOffset ;
//                  if(newoffset < _scrollController.offset ) {
//
//                  }
//                  _scrollController.animateTo(newoffset, duration: Duration(milliseconds: 200), curve: Curves.easeInOut );
////                  if(newoffset > 0) {
////                    print('11111111111');
////                    _scrollController.animateTo(newoffset, duration: Duration(milliseconds: 200), curve: Curves.easeInOut );
////                  }else {
////                    print('12222222');
////                    if(_scrollController.offset > 0) {
////                      _scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.easeInOut );
////                    }
////                  }
//                }
//
//              }else {
//                if(selctOffset < maxOffset && (maxOffset - selctOffset) > height * 0.5 ) {
//                  _scrollController.animateTo(offset, duration: Duration(milliseconds: 200), curve: Curves.easeInOut );
//                }
//              }
//            }

          }

        }
        if(!selctBool){
          _scrollsetelctid((i+1).toString());
        }
      },
    );
  }

  Future _scrollsetelctid(String index) async{
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      selctid = index;
    });
  }



  //右侧组件：
  Widget _rightCateWidget(rightItemWidth, rightItemHeigth) {
    return Container(
      color: Colours.color_f5f5,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView.builder(
          itemCount: this.ListRight.length,
          shrinkWrap: true,//类似与自动布局自动撑开设置
          itemBuilder:(context,index){
            return rightGridViewWidget(index,rightItemWidth,rightItemHeigth);
          }
      ) ,
    );
  }



  Widget rightGridViewWidget(int index ,rightItemWidth, rightItemHeigth) {
    CalssifcationModelRightgirder model = ListRight[index];
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 10, 5),
          child: Text(
            model.title,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colours.color_3333, fontSize: 16,fontWeight:FontWeight.w700),
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
            decoration: BoxDecoration(
                color: Colours.color_ffff,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),

            child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true, //自动撑开布局
                    scrollDirection: Axis.vertical,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: rightItemWidth / rightItemHeigth,
                    physics: NeverScrollableScrollPhysics(),//grid禁止滚动
                    children: getgirdList(model.moudle),
         )),
      ],
    );

  }
  List<Widget> getgirdList(List moudle) {
   return moudle.map((e) => getGridViewItem(e)).toList();
  }
  Widget getGridViewItem(CalssifcationModelRightgirderMoudle model) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
    CachedNetworkImage(
    imageUrl: model.url,
      placeholder: (context, url) => new Icon(
        Icons.image,
        color: Colors.white,
        size: AppSize.width(60),
      ),
      errorWidget: (context, url, error) => new Icon(
        Icons.image,
        color: Colors.white,
        size: AppSize.width(60),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        model.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: AppSize.fontSize(32)),
      ),
    )]
    );
  }



}
