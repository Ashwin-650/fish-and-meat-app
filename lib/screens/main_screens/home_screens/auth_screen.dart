import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/auth_screen_controller/Auth_Controller.dart';
import 'package:fish_and_meat_app/widgets/auth_screen_widgets/login_page.dart';
import 'package:fish_and_meat_app/widgets/auth_screen_widgets/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => _buildNavButton('Login', 0)),
              const SizedBox(width: 10),
              Obx(() => _buildNavButton('Sign up', 1)),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.only(top: 16),
        child: PageView(
          controller: authController.pageController,
          onPageChanged: (int page) => authController.currentPage.value = page,
          children: [
            LoginPage(),
            SignupPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int page) {
    final bool isActive = authController.currentPage.value == page;
    return ElevatedButton(
      onPressed: isActive ? null : () => authController.navigateToPage(page),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.teal : Colors.transparent,
        foregroundColor: isActive ? Colors.white : Colors.grey,
        disabledBackgroundColor: Colors.teal,
        disabledForegroundColor: Colors.white,
        elevation: isActive ? 0 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Appfontsize.small14,
        ),
      ),
    );
  }
}
