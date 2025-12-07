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
  // 特惠推荐列表
  SpecialRecommendation _specialRecommendationList = SpecialRecommendation(
    id: "",
    title: "",
    subTypes: [],
  );
  // 热榜推荐列表
  SpecialRecommendation _inVogueList = SpecialRecommendation(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐列表
  SpecialRecommendation _oneStopList = SpecialRecommendation(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 获取推荐列表
  void _getRecommendList() async {
    final res = await getRecommendListAPI();
    _recommendList = res;
    setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    final res = await getInVogueListApi();
    _inVogueList = res;
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    final res = await getOneStopListApi();
    _oneStopList = res;
    setState(() {});
  }

  // 获取分类列表
  void _getCategoryList() async {
    final res = await getCategoryListApi();
    _categoryList = res;
    setState(() {});
  }

  List<BannerItem> _bannerList = [];

  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialRecommendationList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  // 获取特惠推荐列表
  void _getSpecialRecommendationList() async {
    try {
      final res = await getSpecialRecommendationListApi();
      print("特惠推荐API返回数据: ${res.subTypes.length}");
      if (res.subTypes.isNotEmpty) {
        print("第一个子类型商品数量: ${res.subTypes.first.goodsItems.items.length}");
      }
      _specialRecommendationList = res;
      setState(() {});
    } catch (e) {
      print("获取特惠推荐列表错误: $e");
    }
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

      SliverToBoxAdapter(
        child: HmSuggestion(
          specialRecommendationList: _specialRecommendationList,
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: HmHot(result: _inVogueList, type: "hot"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: HmHot(result: _oneStopList, type: "step"),
            ),
          ],
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
