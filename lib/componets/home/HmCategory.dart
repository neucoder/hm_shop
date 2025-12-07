import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  // 分类列表
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (ctx, index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            // height: 40,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.categoryList[index].picture,
                  width: 40,
                  height: 40,
                ),
                Text(
                  widget.categoryList[index].name,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
