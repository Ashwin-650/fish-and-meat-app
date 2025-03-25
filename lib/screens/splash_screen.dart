import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              // color: Color(0xffd2ebf0),
              color: Appcolor.backgroundColor),
          child: Center(
            child: 'MEATZY'.extenTextStyle(
                fontsize: 36, fontWeight: FontWeight.w900, color: Colors.white),
          )),
    );
  }

  getToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.off(() => const OnboardScreen());
    }
  }
}
