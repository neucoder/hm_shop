import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/componets/home/HmCategory.dart';
import 'package:hm_shop/componets/home/HmHot.dart';
import 'package:hm_shop/componets/home/HmMoreList.dart';
import 'package:hm_shop/componets/home/HmSlider.dart';
import 'package:hm_shop/componets/home/HmSuggestion.dart';
import 'package:hm_shop/utils/Toastutils.dart';
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
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int requsetLimit = _page * 8;
    final res = await getRecommendListAPI({"limit": requsetLimit.toString()});
    _recommendList = res;
    setState(() {});
    _isLoading = false;
    if (_recommendList.length < requsetLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    final res = await getInVogueListApi();
    _inVogueList = res;
    // setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    final res = await getOneStopListApi();
    _oneStopList = res;
    // setState(() {});
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    final res = await getCategoryListApi();
    _categoryList = res;
    // setState(() {});
  }

  List<BannerItem> _bannerList = [];

  void initState() {
    super.initState();
    // _getBannerList();
    // _getCategoryList();
    // _getSpecialRecommendationList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();
    _registerScrollController();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  // 注册滚动控制器
  void _registerScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        // 滚动到最底部
        _getRecommendList();
        // print("滚动到最底部");
      }
    });
  }

  // 获取特惠推荐列表
  Future<void> _getSpecialRecommendationList() async {
    try {
      final res = await getSpecialRecommendationListApi();
      print("特惠推荐API返回数据: ${res.subTypes.length}");
      if (res.subTypes.isNotEmpty) {
        print("第一个子类型商品数量: ${res.subTypes.first.goodsItems.items.length}");
      }
      _specialRecommendationList = res;
      // setState(() {});
    } catch (e) {
      print("获取特惠推荐列表错误: $e");
    }
  }

  Future<void> _getBannerList() async {
    final res = await getBannerListApi();
    _bannerList = res;
    // setState(() {});
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

  // 滚动控制器
  ScrollController _scrollController = ScrollController();

  // 下拉刷新
  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendationList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    _paddingTop = 0;
    setState(() {});
    ToastUtils.showToast(context, "刷新成功");
  }

  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          slivers: _getScrollChildren(),
          controller: _scrollController,
        ),
      ),
    );
  }
}
