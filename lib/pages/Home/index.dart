import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/componets/home/HmCategory.dart';
import 'package:hm_shop/componets/home/HmHot.dart';
import 'package:hm_shop/componets/home/HmMoreList.dart';
import 'package:hm_shop/componets/home/HmSlider.dart';
import 'package:hm_shop/componets/home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 分类列表
  List<CategoryItem> _categoryList = [];

  // 获取分类列表
  void _getCategoryList() async {
    final res = await getCategoryListApi();
    _categoryList = res;
    setState(() {});
  }

  List<BannerItem> _bannerList = [
    // BannerItem(id: "1", imgUrl: "http://127.0.0.1:8080/banner/1.jpg"),
    // BannerItem(id: "2", imgUrl: "http://127.0.0.1:8080/banner/2.jpg"),
    // BannerItem(id: "3", imgUrl: "http://127.0.0.1:8080/banner/3.jpg"),
    // BannerItem(id: "4", imgUrl: "http://127.0.0.1:8080/banner/4.jpg"),
    // BannerItem(id: "5", imgUrl: "http://127.0.0.1:8080/banner/5.jpg"),
    // BannerItem(id: "6", imgUrl: "http://127.0.0.1:8080/banner/6.jpg"),
    // BannerItem(id: "7", imgUrl: "http://127.0.0.1:8080/banner/7.jpg"),
  ];

  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
  }

  void _getBannerList() async {
    final res = await getBannerListApi();
    _bannerList = res;
    setState(() {});
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmSuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(child: HmHot()),
            SizedBox(width: 10),
            Expanded(child: HmHot()),
          ],
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
