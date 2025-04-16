import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/sub_screen_controllers/verification_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final VerificationController controller = Get.put(VerificationController());
  // Timer for resend functionality

  String get _timerText {
    final secs = controller.secondsRemaining.value;
    int minutes = secs ~/ 60;
    int seconds = secs % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

//

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};

    controller.setArguments(
        emailArg: args['email'] ?? '', numberArg: args['number'] ?? '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'OTP Verification'.extenTextStyle(
          color: Colors.teal,
          fontSize: Appfontsize.appBarHeadSize,
          fontWeight: FontWeight.bold,
        ),

        //backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'Verification Code'.extenTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),

              const SizedBox(height: 10),

              'We have sent the verification code to your mobile number'
                  .extenTextStyle(
                fontSize: Appfontsize.regular16,
                color: Colors.black54,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // OTP input fields
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 50,
                      child: TextField(
                        controller: controller.controllers[index],
                        focusNode: controller.focusNodes[index],
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
                            controller.focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Resend timer and button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Didn't receive the code? ".extenTextStyle(
                    fontSize: Appfontsize.small14,
                    color: Colors.black54,
                  ),
                  controller.canResend.value
                      ? InkWell(
                          onTap: controller.resendOTP,
                          child: "Resend".extenTextStyle(
                            fontSize: Appfontsize.small14,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        )
                      : _timerText.extenTextStyle(
                          fontSize: Appfontsize.small14,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                ],
              ),

              const SizedBox(height: 40),

              // Verify button
              CommonButton(
                  onPress: () => controller.verifyOTP(context),
                  buttonText: "Verify")
            ],
          ),
        ),
      ),
    );
  }
}
