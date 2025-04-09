import 'dart:async';
import 'dart:convert';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/screens/myhomepage.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/firebase_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  // Controllers for each digit input
  final String email = Get.arguments;
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // Focus nodes for each input field
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // Timer for resend functionality
  Timer? _timer;
  int _secondsRemaining = 300; // 5 minutes = 300 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  String get _timerText {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _resendOTP() async {
    if (_canResend) {
      final response = await ApiService.resendOTP(email: email, number: "");
      if (response != null && response.statusCode == 200) {
        // Reset the timer
        _startTimer();

        // Show feedback to user
        if (mounted) {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'OTP has been resent',
              backgroundColor: Colors.teal,
            ),
          );
        }
      }
    }
  }

  void _verifyOTP() async {
    String otp = _controllers.map((controller) => controller.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 6 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      var response = await ApiService.verifyOTP(email, otp);
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        final token = jsonData["data"]["token"];

        await SharedPreferencesServices.setValue("login_token", token);

        FirebaseServices firebaseServices = FirebaseServices();
        await firebaseServices.initializeFirebase();

        final fcmToken = await firebaseServices.getToken();
        if (fcmToken != null) {
          final fcmResponse = await ApiService.fcmTokenToServer(
            token: token,
            fcmToken: fcmToken,
          );

          if (fcmResponse != null && fcmResponse.statusCode == 200) {
            print('✅ FCM token registered successfully');
          } else {
            print('⚠️ Failed to register FCM token');
          }
        }

        Get.offAll(const Myhomepage());
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
  void dispose() {
    // Dispose controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'OTP Verification',
          style: TextStyle(
            color: Colors.teal,
            fontSize: Appfontsize.appBarHeadSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verification Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We have sent the verification code to your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Appfontsize.regular16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.teal.withAlpha(50)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.teal.withAlpha(50),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Resend timer and button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: Appfontsize.small14,
                      color: Colors.black54,
                    ),
                  ),
                  _canResend
                      ? InkWell(
                          onTap: _resendOTP,
                          child: const Text(
                            "Resend",
                            style: TextStyle(
                              fontSize: Appfontsize.small14,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        )
                      : Text(
                          _timerText,
                          style: const TextStyle(
                            fontSize: Appfontsize.small14,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                ],
              ),

              const SizedBox(height: 40),

              // Verify button
              CommonButton(onPress: _verifyOTP, buttonText: "Verify")
            ],
          ),
        ),
      ),
    );
  }
}
