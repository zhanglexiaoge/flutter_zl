import 'package:flutter/material.dart';
import 'package:zlapp/Page/Home/homePage.dart';
import 'package:zlapp/Page/Shop/shopPage.dart';
import 'package:zlapp/Page/Order/orderPage.dart';
import 'package:zlapp/Page/Mine/mine.dart';
import 'package:zlapp/_const/colorsConst.dart';
class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '商城', '购物车','我的'];
  PageController _controller = PageController(initialPage: 0);
  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList = new List<StatefulWidget>();
  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _selectedIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color:Colours.color_76fc));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: Colours.color_3333));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage('assets/images/appTabbar/shouye.png'), getTabImage('assets/images/appTabbar/shouye-2.png')],
      [getTabImage('assets/images/appTabbar/shangcheng.png'), getTabImage('assets/images/appTabbar/shangcheng-2.png')],
      [getTabImage('assets/images/appTabbar/gouwuchekong.png'), getTabImage('assets/images/appTabbar/gouwuchekong-2.png')],
      [getTabImage('assets/images/appTabbar/wode.png'), getTabImage('assets/images/appTabbar/wode-2.png')]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new HomePage(),
      new ShopPage(),
      new OrderPage(),
      new MinePage(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    //初始化数据
    initData();
    return Scaffold( //脚手架
      body:_buildBodyWidget(),
      bottomNavigationBar: _getNavigationBar(),
    );
  }
  Widget _buildBodyWidget() {
    return PageView.builder(
      controller: _controller,
      itemCount:  _pageList.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  _pageList[index];
      },
      onPageChanged: (index) {
        if (index != _selectedIndex) {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
    );
  }

  /*
   * 创建底部导航栏
   */
  BottomNavigationBar _getNavigationBar() {
    return new BottomNavigationBar(
      items: <BottomNavigationBarItem> [
        new BottomNavigationBarItem(
            icon: getTabIcon(0), title: getTabTitle(0)
        ),
        new BottomNavigationBarItem(
            icon: getTabIcon(1), title: getTabTitle(1)
        ),
        new BottomNavigationBarItem(
            icon: getTabIcon(2), title: getTabTitle(2)
        ),
        new BottomNavigationBarItem(
            icon: getTabIcon(3), title: getTabTitle(3)
        ),
      ],
      type: BottomNavigationBarType.fixed,
      //默认选中首页
      currentIndex: _selectedIndex,
      iconSize: 20.0,
      //点击事件
      onTap: (index) {
        //_pageChange(index);
        _controller.jumpToPage(index);

      },
    );
  }
}
