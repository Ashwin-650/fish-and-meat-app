import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/auth_screen.dart';
import 'package:fish_and_meat_app/screens/myhomepage.dart';
import 'package:fish_and_meat_app/screens/onboard_screen.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => Future.delayed(const Duration(seconds: 3), getToCheck));
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 95),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade400,
              borderRadius: BorderRadius.circular(10)),
          height: 60,
          child: 'MEATZY'.extenTextStyle(
              fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> getToCheck() async {
    final result = await SharedPreferencesServices.getValue(
        Globals.onboardDisplayed, false);

    if (!result) {
      await SharedPreferencesServices.setValue(Globals.onboardDisplayed, true);
      Get.off(() => OnboardScreen());
    } else {
      final token =
          await SharedPreferencesServices.getValue(Globals.apiToken, '');
      if (token != '' && token.isNotEmpty) {
        Get.off(() => Myhomepage());
      } else {
        Get.off(() => AuthScreen());
      }
    }
  }
}
