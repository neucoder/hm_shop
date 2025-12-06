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
  late CarouselSliderController _carouselController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

  // 搜索框
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      height: 50,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text("搜索商品", style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _getSlider() {
    // 获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _carouselController,
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
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // 指示灯导航组件
  Widget _getIndicator() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.bannerList.length,
          (index) => GestureDetector(
            onTap: () {
              if (_carouselController != null) {
                _carouselController.animateToPage(index);
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: _currentIndex == index ? 40 : 20,
              height: 10,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getIndicator()]);
  }
}
