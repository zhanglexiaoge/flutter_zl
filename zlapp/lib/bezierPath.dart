import 'package:flutter/material.dart';

///贝塞尔 裁剪图形
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    ///圆角
    double roundnessFactor = 20.0;
    Path path = Path();

    //移动到A点
    path.moveTo(0, roundnessFactor);

    ///二阶贝塞尔曲线 画圆角 左上圆角
    path.quadraticBezierTo(0, 0, roundnessFactor, 0);

    ///二阶贝塞尔曲线 画圆弧 起点为(roundnessFactor, 0)
    path.quadraticBezierTo(
        size.width / 2.0, roundnessFactor, size.width - roundnessFactor, 0);

    ///右上圆角
    path.quadraticBezierTo(size.width, 0, size.width, roundnessFactor);

    ///右侧线 起点 size.width, roundnessFactor
    path.lineTo(size.width, size.height - roundnessFactor);

    ///右圆角 起点 size.width, size.height - roundnessFactor

    path.quadraticBezierTo(
        size.width, size.height, size.width - roundnessFactor, size.height);

    ///底部线 起点 size.width - roundnessFactor, size.height
    path.lineTo(roundnessFactor, size.height);

    /// 左下角圆角 起点 roundnessFactor, size.height

    path.quadraticBezierTo(0, size.height, 0, size.height - roundnessFactor);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BezierPathScene extends StatefulWidget {
  const BezierPathScene({super.key});

  @override
  State<BezierPathScene> createState() => _BezierPathSceneState();
}

class _BezierPathSceneState extends State<BezierPathScene> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //定义裁切路径
        child: ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        ///height: 550,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text('test自适应高度'),
            SizedBox(
              height: 15,
            ),
            Text('test自适应高度111111111111111111'),
            SizedBox(
              height: 15,
            ),
            Text(
                'testBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipper'),
            SizedBox(
              height: 15,
            ),
            Text(
                'test自适应高度BackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipperBackgroundClipper'),
            SizedBox(
              height: 30,
            ),
          ],
        ),

        width: 350,
        //背景装饰
        decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
            //渐变使用到的颜色
            colors: [Colors.orange, Colors.blue],
            //开始位置为右上角
            begin: Alignment.topCenter,
            //结束位置为左下角
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ));
  }
}
