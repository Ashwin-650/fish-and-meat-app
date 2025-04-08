import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

extension TextExtention on String {
  Widget extenTextStyle({
    double? fontsize,
    FontWeight? fontWeight,
    String? fontfamily = Appfonts.appFontFamily,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(
      this,
      style: TextStyle(
        decoration: decoration,
        fontFamily: fontfamily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
