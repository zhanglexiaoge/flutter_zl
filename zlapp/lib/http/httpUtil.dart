import 'package:dio/dio.dart';
import 'package:zlapp/_const/serviceUrl.dart';
import 'dart:convert';
import 'package:zlapp/Router/routes.dart';
import 'package:zlapp/utitl/application.dart';
import 'package:zlapp/_const/nsLog.dart';
import 'package:flutter/material.dart';
import 'package:zlapp/utitl/loadingToast.dart';
/*
通用格式
{
    "data":{},
    "errorCode":0,
    "errorMsg":""
}
* */

HttpUtils httpUtils = HttpUtils();

///http请求封装
class HttpUtils {
  HttpUtils._internal() {
    if (null == _dio) {
      _dio = Dio();
      //dio 也是单例,设置baseUrl等一些配置
      _dio.options.baseUrl = BaseserviceUrl;
      _dio.options.connectTimeout = 30 * 1000;
      _dio.options.sendTimeout = 30 * 1000;
      _dio.options.receiveTimeout = 30 * 1000;
    }
  }

  static HttpUtils _singleton = HttpUtils._internal();

  factory HttpUtils() => _singleton;

  Dio _dio;

//  Future get(String url, {Map<String, dynamic> params}) async {
//    Response response;
//
//    try {
//      if (params != null) {
//        response = await _dio.get(url, queryParameters: params);
//      } else {
//        response = await _dio.get(url);
//      }
//
//      if (response.data['errorCode'] == 0) {
//        //这里直接把data部分给搞出来,免得每次在外面去解析˛
//        return response.data['data'];
//      } else {
//        String data = response.data["errorMsg"];
//        NSLog.e("请求网络错误 : $data");
//      }
//    } on DioError catch (e) {
//      if (e.response != null) {
//        NSLog.e(e.response.headers.toString());
//        NSLog.e(e.response.request.toString());
//      } else {
//        NSLog.e(e.request.toString());
//      }
//      return null;
//    }
//  }
//
//  ///post请求
//  ///url : 地址
//  ///formData : 请求参数
//  Future post(String url,
//      {Map<String, dynamic> params}) async {
//    Response response;
//
//    try {
//      if (params != null) {
//        response = await _dio.post(url, queryParameters: params);
//      } else {
//        response = await _dio.post(url);
//      }
//
//      if (response.data['errorCode'] == 0) {
//        //这里直接把data部分给搞出来,免得每次在外面去解析˛
//        return response.data['data'];
//      } else {
//        String data = response.data["errorMsg"];
//
//        NSLog.e("请求网络错误 : $data");
//      }
//    } on DioError catch (e) {
//      if (e.response != null) {
//        NSLog.e(e.response.headers.toString());
//        NSLog.e(e.response.request.toString());
//      } else {
//        NSLog.e(e.request.toString());
//      }
//      return null;
//    }
//  }

  Future getRequset(String url, {Map<String, dynamic> params, bool isAddLoading = false, BuildContext context, String loadingText}) async {
    Response response;
//    //添加token
//    _dio.interceptors.add(InterceptorsWrapper( onRequest:(RequestOptions options){
//      // 在发送请求之前做一些预处理
//      //我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
//      //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
//       _dio.lock();
//       Future<dynamic> futureToken = Future(()async{
//         return await  Application.sp.getToken();
//       });
//       return futureToken.then((value) {
//         options.headers["Authorization"] = value;
//         return options;
//       }).whenComplete(() => _dio.unlock());
//    },
//    onResponse:(Response response) {
//         // 在返回响应数据之前做一些预处理
//         return response; // continue
//    },
//    onError: (DioError e) {
//       // 当请求失败时做一些预处理
//        return e;//continue
//    }
//    ));
//    _dio.options.headers["Authorization"] = Application.sp.getToken();

    //loading
    if (isAddLoading) {
      LodingToast.showLoading(context, loadingText);
    }

    try {
      if (params != null) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.get(url);
      }

      //隐藏loading
      LodingToast.disMissLoadingDialog(isAddLoading, context);

      if (response.data['errorCode'] == 0) {
        //这里直接把data部分给搞出来,免得每次在外面去解析˛
        return response.data['data'];
      } else {
        String data = response.data["errorMsg"];
        LodingToast.showToast(msg: data);
        NSLog.e("请求网络错误 : $data");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        NSLog.e(e.response.headers.toString());
        NSLog.e(e.response.request.toString());
      } else {
        NSLog.e(e.request.toString());
      }

      //ToolUtils.showToast(msg: handleError(e));
      LodingToast.disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  ///post请求
  ///url : 地址postRequset
  ///formData : 请求参数
  Future postRequset(String url,
      {Map<String, dynamic> params, bool isAddLoading = false, BuildContext context, String loadingText}) async {
    Response response;
//    //添加token
//    _dio.interceptors.add(InterceptorsWrapper( onRequest:(RequestOptions options){
//      // 在发送请求之前做一些预处理
//      //我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
//      //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
//      _dio.lock();
//      Future<dynamic> futureToken = Future(()async{
//        return await  Application.sp.getToken();
//      });
//      return futureToken.then((value) {
//        options.headers["Authorization"] = value;
//        return options;
//      }).whenComplete(() => _dio.unlock());
//    },
//        onResponse:(Response response) {
//          // 在返回响应数据之前做一些预处理
//          return response; // continue
//        },
//        onError: (DioError e) {
//          // 当请求失败时做一些预处理
//          return e;//continue
//        }
//    ));

   //添加cookies
    _dio.interceptors.add(InterceptorsWrapper( onRequest:(RequestOptions options){
      // 在发送请求之前做一些预处理
      //我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
      //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
      _dio.lock();
      Future<dynamic> futureCookie = Future(()async{
        return null;
      });
      return futureCookie.then((value) {
        options.headers["cookie"] = value;
        return options;
      }).whenComplete(() => _dio.unlock());
    },
        onResponse:(Response response) {
          // 在返回响应数据之前做一些预处理
          return response; // continue
        },
        onError: (DioError e) {
          // 当请求失败时做一些预处理
          return e;//continue
        }
    ));


 //   _dio.options.headers["HC-ACCESS-TOKEN"] = Application.sp.getToken();
    //loading
    if (isAddLoading) {
      LodingToast.showLoading(context, loadingText);
    }

    try {
       if (params != null) {
        response = await _dio.post(url, queryParameters: params);
      } else {
        response = await _dio.post(url);
      }

      //隐藏loading
       LodingToast.disMissLoadingDialog(isAddLoading, context);

      //json 数据
      //LogUtil.d(response.toString());

      if (response.data['errorCode'] == 0) {
        //这里直接把data部分给搞出来,免得每次在外面去解析˛
        return response.data['data'];
      } else {
        String data = response.data["errorMsg"];
        LodingToast.showToast(msg: data);
        NSLog.e("请求网络错误 : $data");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        NSLog.e(e.response.headers.toString());
        NSLog.e(e.response.request.toString());
      } else {
        NSLog.e(e.request.toString());
      }
      LodingToast.disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }



}