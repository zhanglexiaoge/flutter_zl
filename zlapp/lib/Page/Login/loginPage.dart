import 'package:flutter/material.dart';
import 'package:zlapp/utitl/setNsTimer.dart';
import 'package:zlapp/Page/Login/user_model_entity.dart';
import 'package:zlapp/http/httpUtil.dart';
import 'package:zlapp/_const/serviceUrl.dart';
import 'package:zlapp/_const/const.dart';
import 'package:zlapp/utitl/application.dart';
import 'package:zlapp/Router/routes.dart';
import 'dart:convert';
import 'package:zlapp/EventBus/eventBusAll.dart';
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String buttonText = '验证码'; //初始文本
  TimerUtil timerCountDown; //定时器
  final _formKey = GlobalKey<FormState>();//设置globalKey，用于后面获取FormState
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _verifyController = new TextEditingController();
  String _name;
  String _password;
  String _verify;
  bool isLogin = false;//默认登录按钮不可点击
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loginBody(context),
      ),
    );
  }

  loginBody(BuildContext context) =>
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields(context)],
        ),
      );

  loginHeader() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "欢迎ZLApp",
           // style: TextStyle(fontWeight: FontWeight.w700, color: Colours.color_76fc),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      );

  loginFields(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          child:Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "您的用户名",
                    icon: Icon(Icons.person)
                ),
                onSaved: (val) {
                  _name = val;
                },
                onChanged: (String val){
                  _isLoginAction();
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    icon: Icon(Icons.lock)
                ),
                obscureText: true,
                onSaved: (val) {
                  _password = val;
                },
                onChanged: (String val){
                  _isLoginAction();
                },
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _verifyController,
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: "验证码",
                            hintText: "您的验证码",
                            icon: Icon(Icons.verified_user)
                        ),
                        obscureText: false,
                        //maxLength: 6,
                        onSaved: (val) {
                          _verify = val;
                        },
                        onChanged: (String val){
                          _isLoginAction();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: sendverifyButton(),
                    ),
                  ],
                ),
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                              padding: EdgeInsets.all(12.0),
                              shape: StadiumBorder(),
                              child: Text("登录", style: TextStyle(color: Colors.white),),
                              color: Colours.color_76fc,
                              disabledColor: Colours.color_76fc.withOpacity(0.3),
                              disabledTextColor:Colors.white.withOpacity(0.3),
                              onPressed: isLogin ? () {loginAction(context);} : null,
                            ),

                    ),],),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "注册(默认账号ss1204密码123456验证码随便)",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
  /*校验loginButton是否可以点击 */
  void _isLoginAction() {
    String name =  _unameController.text;
    String passwordStr = _pwdController.text;
    String verifyStr = _verifyController.text;
    if(name.length > 0 && passwordStr.length > 0 && verifyStr.length > 0) {
      setState(() {
        isLogin = true;
      });
    }else {
      setState(() {
        isLogin = false;
      });
    }
  }

  /*发送验证码button */
  Widget sendverifyButton() {
    return FlatButton(
      disabledColor: Colors.grey.withOpacity(0.1),
      //按钮禁用时的颜色
      disabledTextColor: Colors.white,
      //按钮禁用时的文本颜色
      textColor: Colors.white ,
      //文本颜色
      color:  Color(0xff44c5fe),
      //按钮的颜色
      splashColor:Colors.white.withOpacity(0.1),
      shape: StadiumBorder(side: BorderSide.none),
      onPressed: () {
        _buttonClickverify();
      },
      child: Text('$buttonText', style: TextStyle(fontSize: 13,),),
    );
  }

  void _buttonClickverify() {
    String name =  _unameController.text;
    String passwordStr = _pwdController.text;
    if(timerCountDown == null) {
      if(name.length > 0 && passwordStr.length > 0) {
        _initTimer();
        sendSmsAction(name,passwordStr);
      }else {
        //用户名密码不能为空
      }
    }
  }

  //初始化定时器
  void _initTimer() {
    timerCountDown = new TimerUtil(mInterval: 1000, mTotalTime: 60 * 1000);
    timerCountDown.setOnTimerTickCallback((int value) {
      double count = (value / 1000);
      int tick = count.toInt();
      setState(() {
        if (tick == 0) {
          if (timerCountDown != null)
            timerCountDown.cancel(); //dispose() //销毁计时器
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($tick)'; //更新文本内容
        }
      });
    });
    timerCountDown.startCountDown();
  }


  Future<void> loginAction( BuildContext context ) async {
    var _state = _formKey.currentState;
    if(_state.validate()) {
      _state.save();
      print(_name);
      print(_password);
      print(_verify);
      Map<String, dynamic> params = {"username": _name,"password":_password};
      Map<dynamic, dynamic> user = await httpUtils.postRequset(loginOld,params: params,isAddLoading: true,context: context);
      // Map<String, dynamic> key 标识 必须是String类型 如需要可以这样转换 new Map<String, dynamic>.from(user)
      if(user != null ){
        UserModelEntity model = UserModelEntity.fromJson(user);
        Application.sp.putString(SharedPreferencesKeys.USER_MODEL, json.encode(user));
        Application.router.navigateTo(context, Routes.tabbarpage,clearStack: true);
        //发送通知
        eventBus.fire(UserModelEvent(model));
      }
    }
  }

  //发送验证码 需要请求接口
  Future<void> sendSmsAction(String name,String passwordStr) async {
//    Map<String, dynamic> params = {"username": name,"password":passwordStr};
//    HttpUtil.instance.post(sendSms,params: params).then((data) {
//      print('data: ' + data.toString());
//    },onError: (error){
//
//    });
  }


}

