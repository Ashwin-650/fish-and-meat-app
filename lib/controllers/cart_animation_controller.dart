import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAnimationController extends GetxController {
  final GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  void setAnimationFunction(Function(GlobalKey) callback) {
    runAddToCartAnimation = callback;
  }

  void triggerAddToCartAnimation(GlobalKey widgetKey) {
    if (runAddToCartAnimation != null) {
      runAddToCartAnimation(widgetKey);
    } else {
      debugPrint("runAddToCartAnimation is not set");
    }
  }
}
