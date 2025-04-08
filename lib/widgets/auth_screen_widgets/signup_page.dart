import 'package:fish_and_meat_app/screens/main_screens/sub_screens/verification_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/auth_screen_widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool? _isConditionsAgreed = false;

  void _signupPressed() async {
    if (_signupFormKey.currentState?.validate() ?? false) {
      if (_isConditionsAgreed!) {
        final response = await ApiService.registerAccount(
          _fullnameController.text,
          _emailController.text,
          _numberController.text,
        );
        if (response != null &&
            (response.statusCode == 200 ||
                response.statusCode == 201 ||
                response.statusCode == 202)) {
          Get.to(
            const VerificationScreen(),
            arguments: _emailController.text,
          );
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.body),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            message:
                "You have to agree the Terms and Privacy Policy to continue",
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
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
            key: _signupFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),
                // Title
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Full Name
                CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your name',
                    textController: _fullnameController),
                const SizedBox(height: 20),
                // Email
                CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    textController: _emailController,
                    isEmail: true),
                const SizedBox(height: 20),
                // Mobile Number
                CustomTextField(
                    label: 'Mobile Number',
                    hint: 'Enter your mobile number',
                    textController: _numberController,
                    isNumber: true),
                const SizedBox(height: 20),
                // Terms Agreement
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _isConditionsAgreed,
                        onChanged: (value) {
                          setState(() {
                            _isConditionsAgreed = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'I agree to the Terms and Privacy Policy',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                SizedBox(
                    width: double.infinity,
                    child: CommonButton(
                        onPress: _signupPressed, buttonText: "Sign up")),
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
                        'Or sign up with',
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
