import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  void navigateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    currentPage.value = page;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
