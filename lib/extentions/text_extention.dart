import 'package:flutter/material.dart';

extension TextExtention on String {
  Widget extenTextStyle({
    double? fontsize,
    FontWeight? fontWeight,
    String? fontfamily,
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
