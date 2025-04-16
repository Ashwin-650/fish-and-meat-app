import 'dart:async';
import 'dart:convert';

import 'package:fish_and_meat_app/helpers/update_fcm_token.dart';
import 'package:fish_and_meat_app/screens/myhomepage.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/firebase_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  var email = ''.obs;
  var number = ''.obs;
  final RxList<TextEditingController> controllers = RxList.generate(
    6,
    (index) => TextEditingController(),
  );

  // Focus nodes for each input field
  final List<FocusNode> focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? timer;
  RxInt secondsRemaining = 300.obs; // 5 minutes = 300 seconds
  RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      email.value = Get.arguments["email"];
      number.value = Get.arguments["number"];
    }
    _startTimer();
  }

  void setArguments({required String emailArg, required String numberArg}) {
    email.value = emailArg;
    number.value = numberArg;
    print("✅ Arguments set: email = $emailArg, number = $numberArg");
  }

  void _startTimer() {
    canResend.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        canResend = true.obs;
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    if (canResend.value) {
      final response =
          await ApiService.resendOTP(email: email.value, number: number.value);
      if (response != null && response.statusCode == 200) {
        // Reset the timer
        _startTimer();

        // Show feedback to user

        Get.showSnackbar(
          const GetSnackBar(
            message: 'OTP has been resent',
            backgroundColor: Colors.teal,
          ),
        );
      }
    }
  }

  void verifyOTP(BuildContext context) async {
    String otp = controllers.map((controller) => controller.text).join();
    print("Entered OTP: $otp"); // ✅ ADD THIS

    if (otp.length != 6) {
      print("OTP not complete"); // ✅
      print("Sending verify request with:");
      print("Email: ${email.value}, Number: ${number.value}, OTP: $otp");

      return;
    }

    try {
      var response = await ApiService.verifyOTP(
          email: email.value, number: number.value, otp: otp);
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        final token = jsonData["data"]["token"];

        await SharedPreferencesServices.setValue("login_token", token);

        FirebaseServices firebaseServices = FirebaseServices();
        await firebaseServices.initializeFirebase();

        final fcmToken = await firebaseServices.getToken();
        if (fcmToken != null) {
          updateFCMToken(token: token, fcmToken: fcmToken);
        }

        Get.offAll(Myhomepage());
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void onClose() {
    super.onClose();

    // Dispose controllers and focus nodes
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    timer?.cancel();
  }
}
