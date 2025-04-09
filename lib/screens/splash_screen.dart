import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/auth_screen.dart';
import 'package:fish_and_meat_app/screens/myhomepage.dart';
import 'package:fish_and_meat_app/screens/onboard_screen.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
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
    Future.delayed(const Duration(seconds: 3), checkToken);
    getToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 95),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade400,
              borderRadius: BorderRadius.circular(10)),
          height: 60,
          child: 'MEATZY'.extenTextStyle(
              fontsize: 36, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
    );
  }

  getToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.off(() => const OnboardScreen());
    }
  }

  Future<void> checkToken() async {
    final token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token != null && token.isNotEmpty) {
      Get.off(() => const Myhomepage());
    } else {
      Get.off(() => const AuthScreen());
    }
  }
}
