import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  // 特惠推荐列表
  final SpecialRecommendation specialRecommendationList;
  HmSuggestion({Key? key, required this.specialRecommendationList})
    : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  List<GoodsItem> _getDisplayItems() {
    print(
      "HmSuggestion _getDisplayItems() subTypes长度: ${widget.specialRecommendationList.subTypes.length}",
    );
    if (widget.specialRecommendationList.subTypes.isEmpty) {
      print("HmSuggestion _getDisplayItems() subTypes为空");
      return [];
    }
    final firstSubType = widget.specialRecommendationList.subTypes.first;
    print("HmSuggestion _getDisplayItems() 第一个子类型标题: ${firstSubType.title}");
    print(
      "HmSuggestion _getDisplayItems() 商品数量: ${firstSubType.goodsItems.items.length}",
    );
    return firstSubType.goodsItems.items.take(3).toList();
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> items = _getDisplayItems();
    print("HmSuggestion _getChildrenList() items: $items");
    return List.generate(
      items.length,
      (index) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Image.asset(
                "lib/assets/home_cmd_inner.png",
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
              items[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "¥${items[index].price}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Text(items[index].name, style: TextStyle(fontSize: 12)),
          // Text("¥${items[index].price}", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 143, 7, 7),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            color: const Color.fromARGB(255, 211, 80, 80),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit: BoxFit.cover,
        ),
      ),

      // height: 200,
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 10),
          Row(
            children: [
              _buildLeft(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getChildrenList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
