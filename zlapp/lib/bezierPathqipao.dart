import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  /// 三角形 宽高
  Size trianglesSize;

  double trianglesDx;

  ///三角形位置 x
  double trianglesDy;

  ///三角形位置 y
  BackgroundClipper(this.trianglesSize, this.trianglesDx, this.trianglesDy);
  @override
  Path getClip(Size size) {
    ///圆角
    double roundnessFactor = 10.0;

    double trianglesWidth = trianglesSize.width;

    double trianglesHeight = trianglesSize.height;

    double trianglesX = trianglesDx;

    if (trianglesDx == 0) {
      ///如果不设置x 默认为 0.69
      trianglesX = size.width * 0.69;
    }

    /// 三角形 宽高
    ///
    /// 三角形位置
    Path path = Path();

    //移动到A点
    path.moveTo(0, roundnessFactor);

    ///二阶贝塞尔曲线 画圆角 左上圆角
    path.quadraticBezierTo(0, 0, roundnessFactor, 0);

    ///顶部线

    path.lineTo(size.width - roundnessFactor, 0);

    ///右上圆角
    path.quadraticBezierTo(size.width, 0, size.width, roundnessFactor);

    ///右侧线 起点 size.width, roundnessFactor
    path.lineTo(size.width, size.height - roundnessFactor - trianglesHeight);

    ///右下圆角 起点 size.width, size.height - roundnessFactor

    path.quadraticBezierTo(size.width, size.height - trianglesHeight,
        size.width - roundnessFactor, size.height - trianglesHeight);

    /// 底部线 右侧起点  size.width - roundnessFactor, size.height - trianglesHeight   到三角形右侧点 trianglesX , size.height - trianglesHeight

    path.lineTo(trianglesX - trianglesWidth, size.height - trianglesHeight);

    ///三角形顶点
    path.lineTo(trianglesX - trianglesWidth / 2.0, size.height);

    ///三角形顶点 - 三角形左侧终点
    path.lineTo(trianglesX, size.height - trianglesHeight);

    /// 三角形左侧点到右侧点
    path.lineTo(trianglesX - trianglesWidth, size.height - trianglesHeight);

    /// 三角形底部点 到 左侧圆角起点
    path.lineTo(roundnessFactor, size.height - trianglesHeight);

    /// 左下角圆角 起点 roundnessFactor, size.height - trianglesHeight

    path.quadraticBezierTo(0, size.height - trianglesHeight, 0,
        size.height - roundnessFactor - trianglesHeight);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class bezierPathqipao extends StatefulWidget {
  const bezierPathqipao({super.key});

  @override
  State<bezierPathqipao> createState() => _bezierPathqipaoState();
}

class _bezierPathqipaoState extends State<bezierPathqipao> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //定义裁切路径
        child: ClipPath(
      clipper: BackgroundClipper(Size(12, 6), 0, 0),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 280,
          maxWidth: 320,
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            Text(
              //'test自适应高度1111111111111',
              'test自适应高度BackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperaaasdddfdgfghhhhhhhj',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              maxLines: 2,
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // Text(
            //     'testBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipper'),
            // SizedBox(
            //   height: 15,
            // ),
            // Text(
            //     'test自适应高度BackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipper'),
            SizedBox(
              height: 10 + 6,
            ),
          ],
        ),

        //背景装饰
        decoration: BoxDecoration(
          color: Colors.black,
          // //线性渐变
          // gradient: LinearGradient(
          //   //渐变使用到的颜色
          //   colors: [Colors.orange, Colors.blue],
          //   //开始位置为右上角
          //   begin: Alignment.topCenter,
          //   //结束位置为左下角
          //   end: Alignment.bottomCenter,
          // ),
        ),
      ),
    ));
  }
}
