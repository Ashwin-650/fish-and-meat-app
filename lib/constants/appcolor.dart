import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appcolor {
  static var primaryColor = const Color(0xFF8E4585).obs;
  static Color secondaryColor = const Color(0xFFB0C4DE);

  static const Color backgroundColor = Colors.white;
  static const Color appbargroundColor = Colors.white;
  static Color bottomBarColor = primaryColor.value;
  static Color itemBackColor = primaryColor.value.withAlpha(50);
}
