import 'package:flutter/material.dart';
import 'package:zlapp/Page/Login/user_model_entity.dart';
import 'package:zlapp/utitl/application.dart';
import 'package:zlapp/_const/const.dart';
import 'dart:convert';
import 'package:zlapp/EventBus/eventBusAll.dart';
import 'dart:async';
import 'package:zlapp/utitl/screenUtil.dart';
import 'package:zlapp/Router/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin  {
  //保持状态
  bool get wantKeepAlive => true;
  bool isLogin = false; //是否登录
  UserModelEntity userInfo; //登录信息
  StreamSubscription _userModelscription;//登录信息监听

  File _image;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _userModelscription =  eventBus.on<UserModelEvent>().listen((event){
      //监听值有变化会通知
       _getUserInfo();
    });
  }

  //获取本地登录信息
  _getUserInfo() async{
    String log_info =  await Application.sp.getString(SharedPreferencesKeys.USER_MODEL);
    Map<dynamic, dynamic> mapdy =  new Map<dynamic, dynamic>.from(json.decode(log_info));
    UserModelEntity _userModel = UserModelEntity.fromJson(mapdy);
    setState(() {
      this.isLogin = _userModel != null ? true : false;
      this.userInfo = _userModel;
    });

  }

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: isTakePhoto ? ImageSource.camera :ImageSource.gallery
    );
    setState(() {
       _image = image;
    });
  }
  void dispose() {
    super.dispose();
    //取消订阅
   _userModelscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //根据屏幕适配
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        backgroundColor: Colours.color_f5f5,
        body: MediaQuery.removePadding(context: context,
        removeTop: true,//移除顶部的safe Area
          child: ListView(
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setHeight(220),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(ImageMinePath.icon_user_bg),fit: BoxFit.cover),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:  InkWell(
                      child: getHeader(),
                      onTap: (){
                        //弹出相机 拍照选择
                        showModalBottomSheet(context: context, builder:(BuildContext context){
                          return new  Column(
                                //显示自动撑开布局
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child:Text("拍照",textAlign:TextAlign.center,style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                     )),
                                      height: 50,
                                    ),
                                    onTap: (){
                                      getImage(true);
                                    },
                                  ),

                                  Divider(
                                    height: 1,
                                  ),
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child:Text("从相册中选择",textAlign:TextAlign.center,style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      )),
                                      height: 50,
                                    ),
                                    onTap: (){
                                      getImage(false);
                                    },
                                  ),
                               ],
                              );
                        });
                      },
                    ),
                  ),
                  this.isLogin?Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('用户名：${this.userInfo.username}',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32),color: Colors.white)),
                          Text('普通会员',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24), color: Colors.white)),
                        ],
                      )
                  ):
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          //Navigator.pushNamed(context, '/login');
                        },
                        child: Text('登录',style: TextStyle(color: Colors.white)),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: InkWell(
                        onTap: (){
                          TransitionType transitionType = TransitionType.native;
                          Application.router.navigateTo(context, Routes.setPage,transition:transitionType);
                        },
                        child: Text('设置',style: TextStyle(color: Colours.color_ffff)),
                      )
                  ),

                ],
              ),
            ),
            Divider(
               height: ScreenUtil.getInstance().setHeight(10),
            ),
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.shop,
                      color: Colors.grey,
                    ),
                    title: Text("我的订单"),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.child_friendly,
                      color: Colors.red,
                    ),
                    title: Text("待收货"),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),

            Divider(
              height: ScreenUtil.getInstance().setHeight(10),
            ),
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.lightGreen,
                    ),
                    title: Text("我的收藏"),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Colors.black54,
                    ),
                    title: Text("在线客服"),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
    );
  }

  Widget getHeader() {
    if(this._image != null) {
      return ClipRRect(
        //圆角效果
        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(50)),
        child: Image.file(this._image,width: ScreenUtil.getInstance().setWidth(100),height: ScreenUtil.getInstance().setWidth(100),fit:BoxFit.cover),
      );
    }else {
      return ClipRRect(
        //圆角效果
        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(50)),
        child: Image.asset(ImageMinePath.icon_user_place,width: ScreenUtil.getInstance().setWidth(100),height: ScreenUtil.getInstance().setWidth(100),fit:BoxFit.cover),
      );
    }
  }

}

