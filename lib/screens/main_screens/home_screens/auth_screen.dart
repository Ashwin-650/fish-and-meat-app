import 'package:fish_and_meat_app/widgets/auth_screen_widgets/login_page.dart';
import 'package:fish_and_meat_app/widgets/auth_screen_widgets/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF5F7FA),
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
              _buildNavButton('Login', 0),
              const SizedBox(width: 10),
              _buildNavButton('Sign up', 1),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
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
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: const [
              LoginPage(),
              SignupPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int page) {
    final bool isActive = _currentPage == page;
    return ElevatedButton(
      onPressed: isActive ? null : () => _navigateToPage(page),
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
          fontSize: 14,
        ),
      ),
    );
  }
}
