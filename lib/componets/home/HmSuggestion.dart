import 'package:flutter/material.dart';

class HmSuggestion extends StatefulWidget {
  HmSuggestion({Key? key}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 300,

      child: Text("推荐商品", style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
