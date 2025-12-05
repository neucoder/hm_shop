import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_1.png",
      "active_icon": "lib/assets/ic_1_selected.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_2.png",
      "active_icon": "lib/assets/ic_2_selected.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_3.png",
      "active_icon": "lib/assets/ic_3_selected.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_4.png",
      "active_icon": "lib/assets/ic_4_selected.png",
      "text": "我的",
    },
  ];

  List<BottomNavigationBarItem> _getTabBatWidget() {
    return _tabList.map((item) {
      return BottomNavigationBarItem(
        icon: Image.asset(item["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(item["active_icon"]!, width: 30, height: 30),
        label: item["text"],
      );
    }).toList();
  }

  List<Widget> _getChildren() {
    return [HomePage(), CategoryPage(), CartPage(), MyPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("商城")),
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: _getTabBatWidget(),
        currentIndex: _currentIndex,
      ),
    );
  }
}
