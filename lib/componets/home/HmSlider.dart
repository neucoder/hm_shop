import 'package:flutter/material.dart';

class HmSlider extends StatefulWidget {
  HmSlider({Key? key}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
