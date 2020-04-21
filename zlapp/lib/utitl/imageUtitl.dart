import 'package:flutter/material.dart';
import 'package:zlapp/utitl/utitl.dart';
import 'package:zlapp/_const/imagePath.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zlapp/_const/nsLog.dart';

class ImageUtils {

  static ImageProvider getAssetImage(String path) {
    NSLog.e(path);
    return AssetImage(path);
  }

  static ImageProvider getImageProvider(String imageUrl) {
    //p_url 是占位图路径
    if (ObjectUtil.isEmptyString(imageUrl)) {
      return AssetImage(ImageSplashPath.p_url);
    }
    return CachedNetworkImageProvider(imageUrl, errorListener: () =>  NSLog.e("图片加载失败！"));
  }
}