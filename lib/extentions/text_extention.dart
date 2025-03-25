import 'package:flutter/material.dart';

extension TextExtention on String {
  Widget extenTextStyle(
      {double? fontsize,
      FontWeight? fontWeight,
      String? fontfamily,
      Color? color,
      TextAlign? textAlign,
      TextOverflow? textOverflow}) {
    return Text(
      this,
      style: TextStyle(
        fontFamily: fontfamily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }
}
