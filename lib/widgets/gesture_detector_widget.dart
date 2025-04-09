import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class GestureDetectorWidget extends StatelessWidget {
  final String text;
  final Function onTapFunciton;
  const GestureDetectorWidget(
      {super.key, required this.text, required this.onTapFunciton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunciton();
      },
      child: text.extenTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
