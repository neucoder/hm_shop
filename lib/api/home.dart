import 'package:hm_shop/contants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  final res = await DioRequest().get(HttpConstants.BANNER_URL);
  return (res as List)
      .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
      .toList();
}
