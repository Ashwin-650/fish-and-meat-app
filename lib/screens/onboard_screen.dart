import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page1.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page2.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page3.dart';
import 'package:fish_and_meat_app/screens/main_screens/auth_screen.dart';
import 'package:fish_and_meat_app/screens/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: const [OnboardPage1(), OnboardPage2(), OnboardPage3()],
        ),
        Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: 'Skip'.extenTextStyle(
                    fontsize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Get.off(() => const AuthScreen());
                        },
                        child: 'Start'.extenTextStyle(
                          fontsize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        child: 'Next'.extenTextStyle(
                          fontsize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      )
              ],
            ))
      ],
    ));
  }
}
