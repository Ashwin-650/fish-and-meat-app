import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

extension TextExtention on String {
  Widget extenTextStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      String? fontfamily = Appfonts.appFontFamily,
      Color? color,
      TextAlign? textAlign,
      TextOverflow? textOverflow,
      int? maxLines,
      TextDecoration? decoration,
      bool shadow = false}) {
    return Text(
      this,
      style: TextStyle(
          decoration: decoration,
          fontFamily: fontfamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          shadows: shadow
              ? const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
              : null),
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
