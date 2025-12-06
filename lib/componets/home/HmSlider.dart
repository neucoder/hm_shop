import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider() {
    // 获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(
        widget.bannerList.length,
        (index) => Image.network(
          widget.bannerList[index].imgUrl,
          width: screenWidth,
          fit: BoxFit.cover,
        ),
      ),

      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 2),
        // enlargeCenterPage: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);
  }
}
