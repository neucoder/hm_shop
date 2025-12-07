class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id']?.toString() ?? "",
      imgUrl: json['imgUrl']?.toString() ?? "",
    );
  }
}

class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  dynamic goods;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      children: json['children'] != null
          ? (json['children'] as List)
                .map((e) => CategoryItem.fromJson(e))
                .toList()
          : null,
      goods: json['goods'],
    );
  }
}

// 特惠推荐相关数据模型
class SpecialRecommendation {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialRecommendation({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendation.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendation(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      subTypes:
          (json['subTypes'] as List?)
              ?.map((e) => SubType.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      goodsItems: GoodsItems.fromJson(json['goodsItems'] ?? {}),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items:
          (json['items'] as List?)
              ?.map((e) => GoodsItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      desc: json['desc']?.toString(),
      price: json['price']?.toString() ?? "0.00",
      picture: json['picture']?.toString() ?? "",
      orderNum: json['orderNum'] as int? ?? 0,
    );
  }
}

/**
 * 
 * {
"id": "4027466",
"name": "儿童气泵软底学步二阶段学步鞋",
"price": 239,
"picture": "https://yanxuan-item.nosdn.127.net/19bedfd20a12842b5d7f7b909a62e877.jpg",
"payCount": 0
},
 */

// 根据上面json数据来生成类和工厂方法
class GoodDetailItem {
  String id;
  String name;
  String price;
  String picture;
  int payCount;

  GoodDetailItem({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    required this.payCount,
  });

  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      price: json['price']?.toString() ?? "0.00",
      picture: json['picture']?.toString() ?? "",
      payCount: json['payCount'] as int? ?? 0,
    );
  }
}
