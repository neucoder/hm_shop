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
  return SpecialRecommendation.fromJson(
    await DioRequest().get(HttpConstants.PRODUCT_LIST),
  );
}
