import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/login_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/verification_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

  void _loginPressed() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      final response = await ApiService.loginAccount(
        email: !_loginController.isLoginWithNumber.value
            ? _emailController.text
            : "",
        number: _loginController.isLoginWithNumber.value
            ? _numberController.text
            : "",
      );
      if (response != null && response.statusCode == 200 ||
          response.statusCode == 201) {
        Get.to(
          const VerificationScreen(),
          arguments: {
            'email': _emailController.text,
            'number': _numberController.text
          },
        );
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

                'LOGIN'.extenTextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                const SizedBox(height: 30),
                // Title

                'Welcome back'.extenTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                    textAlign: TextAlign.center),

                const SizedBox(height: 30),
                // Email

                Obx(
                  () => Visibility(
                    visible: _loginController.isLoginWithNumber.value,
                    child: Column(
                      children: [
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
                        TextButton(
                          onPressed: () {
                            _loginController.isLoginWithNumber = false.obs;
                          },
                          child: "Login with email?"
                              .extenTextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !_loginController.isLoginWithNumber.value,
                    child: Column(
                      children: [
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
                        TextButton(
                          onPressed: () {
                            _loginController.isLoginWithNumber = true.obs;
                          },
                          child: "Login with mobile number?"
                              .extenTextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
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
                      child: 'Or continue with'.extenTextStyle(
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
      ),
    );
  }
}
