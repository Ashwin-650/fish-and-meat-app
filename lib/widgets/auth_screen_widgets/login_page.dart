import 'dart:convert';

import 'package:fish_and_meat_app/screens/main_screens/sub_screens/verification_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _isLoginWithNumber = true;

  void _loginPressed() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      final response = await ApiService.loginAccount(
        email: !_isLoginWithNumber ? _emailController.text : "",
        number: _isLoginWithNumber ? _numberController.text : "",
      );
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        print('rep :${response.body}');
        String email = jsonData["data"]["email"];

        Get.to(const VerificationScreen(), arguments: email);
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: 400,
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),
                // Title
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Email

                Visibility(
                  visible: _isLoginWithNumber,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Mobile Number',
                        hint: 'Enter your mobile number',
                        textController: _numberController,
                        isNumber: true,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLoginWithNumber = false;
                          });
                        },
                        child: const Text(
                          "Login with email?",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !_isLoginWithNumber,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        textController: _numberController,
                        isEmail: true,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLoginWithNumber = true;
                          });
                        },
                        child: const Text(
                          "Login with mobile number?",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child:
                      CommonButton(onPress: _loginPressed, buttonText: "Login"),
                ),
                const SizedBox(height: 20),
                // Separator
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFDDDDDD),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFDDDDDD),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Social Login
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(iconText: 'G'),
                    SizedBox(width: 15),
                    SocialButton(iconText: 'f'),
                    SizedBox(width: 15),
                    SocialButton(iconText: 'in'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
