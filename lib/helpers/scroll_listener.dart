import 'package:fish_and_meat_app/controllers/nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

final NavBarController _navBarController = Get.put(NavBarController());

void scrollListener(ScrollController controller) {
  if (controller.position.userScrollDirection == ScrollDirection.reverse) {
    _navBarController.isVisible.value = false;
  }

  if (controller.position.userScrollDirection == ScrollDirection.forward) {
    _navBarController.isVisible.value = true;
  }
}
