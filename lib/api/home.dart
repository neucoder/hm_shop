import 'package:hm_shop/contants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  final res = await DioRequest().get(HttpConstants.BANNER_URL);
  return (res as List)
      .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
      .toList();
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  final res = await DioRequest().get(HttpConstants.CATEGORY_URL);
  return (res as List)
      .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
      .toList();
}

// 获取特惠推荐列表
Future<SpecialRecommendation> getSpecialRecommendationListApi() async {
  final res = await DioRequest().get(HttpConstants.PRODUCT_LIST);
  return SpecialRecommendation.fromJson(res);
}

// 热榜推荐
Future<SpecialRecommendation> getInVogueListApi() async {
  final res = await DioRequest().get(HttpConstants.IN_VOGUE_LIST);
  return SpecialRecommendation.fromJson(res);
}

// 一站式推荐
Future<SpecialRecommendation> getOneStopListApi() async {
  final res = await DioRequest().get(HttpConstants.ONE_STOP_LIST);
  return SpecialRecommendation.fromJson(res);
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, String> params,
) async {
  final res = await DioRequest().get(
    HttpConstants.RECOMMEND_LIST,
    params: params,
  );
  return (res as List)
      .map((e) => GoodDetailItem.fromJson(e as Map<String, dynamic>))
      .toList();
}
