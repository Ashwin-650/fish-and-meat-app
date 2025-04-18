import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/signup_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/verification_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final SignupController _signupController = Get.put(SignupController());

  void _signupPressed() async {
    if (_signupFormKey.currentState?.validate() ?? false) {
      if (_signupController.isConditionsAgreed.value) {
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
            VerificationScreen(),
            arguments: _emailController.text,
          );
        } else {
          Get.showSnackbar(
            GetSnackBar(
              message: response.body,
              backgroundColor: Colors.red,
            ),
          );
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: 400,
        child: Form(
          key: _signupFormKey,
          child: Column(
            spacing: 30,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo

              'SIGN UP'.extenTextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),

              // Title

              'Create an account'.extenTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
                textAlign: TextAlign.center,
              ),

              // Full Name
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your name',
                textController: _fullnameController,
                validator: (value) {
                  if (value.contains(" ")) {
                    return 'Please enter a valid full name';
                  }
                },
              ),
              // Email
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                textController: _emailController,
                isEmail: true,
                validator: (value) {
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                },
              ),
              // Mobile Number
              CustomTextField(
                label: 'Mobile Number',
                hint: 'Enter your mobile number',
                textController: _numberController,
                isMobileNumber: true,
                isNumberField: true,
                validator: (value) {
                  if (value.length > 10 ||
                      !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return 'Please enter a valid mobile number';
                  }
                },
              ),
              // Terms Agreement
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Obx(
                      () => Checkbox(
                        value: _signupController.isConditionsAgreed.value,
                        onChanged: (value) {
                          _signupController.isConditionsAgreed.value = value!;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: 'I agree to the Terms and Privacy Policy'
                        .extenTextStyle(
                      fontSize: Appfontsize.small14,
                      color: const Color(0xFF555555),
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
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Color(0xFFDDDDDD),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: 'Or sign up with'.extenTextStyle(
                      fontSize: Appfontsize.small14,
                      color: const Color(0xFF777777),
                    ),
                  ),
                  const Expanded(
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
    );
  }
}
