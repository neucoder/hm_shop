import 'package:flutter/material.dart';
import 'package:hm_shop/componets/home/HmCategory.dart';
import 'package:hm_shop/componets/home/HmHot.dart';
import 'package:hm_shop/componets/home/HmMoreList.dart';
import 'package:hm_shop/componets/home/HmSlider.dart';
import 'package:hm_shop/componets/home/HmSuggestion.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory()),
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
