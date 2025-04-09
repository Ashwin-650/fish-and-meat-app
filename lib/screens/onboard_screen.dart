import 'package:fish_and_meat_app/controllers/onboard_screen_controllers/onboard_page_index_controller.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page1.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page2.dart';
import 'package:fish_and_meat_app/onboard_pages/onboard_page3.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/auth_screen.dart';
import 'package:fish_and_meat_app/widgets/gesture_detector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});

  final PageController _controller = PageController();
  final OnboardPageIndexController _onboardPageController =
      Get.put(OnboardPageIndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            _onboardPageController.onLastPage.value = index == 2;
          },
          controller: _controller,
          children: const [
            OnboardPage1(),
            OnboardPage2(),
            OnboardPage3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.8),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetectorWidget(
                    text: 'Skip',
                    onTapFunciton: () => _controller.jumpToPage(2),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),
                  _onboardPageController.onLastPage.value
                      ? GestureDetectorWidget(
                          text: 'Start',
                          onTapFunciton: () =>
                              Get.off(() => const AuthScreen()),
                        )
                      : GestureDetectorWidget(
                          text: 'Next',
                          onTapFunciton: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          })
                ],
              ),
            ))
      ],
    ));
  }
}
