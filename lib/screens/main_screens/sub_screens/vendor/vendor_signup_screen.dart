import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/controllers/vendor_mode_controllers/vendor_signup_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/adhaar_number_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/gst_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/pan_number_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorSignUpScreen extends StatelessWidget {
  VendorSignUpScreen({super.key});

  final VendorSignupController controller = Get.put(VendorSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appbargroundColor,
        title: 'Signup'
            .extenTextStyle(fontfamily: Appfonts.appFontFamily, fontSize: 24),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gst Field
                GstFieldWidget(
                  gstController: controller.gstController,
                ),

                // PAN Number Field
                PanNumberFieldWidget(panController: controller.panController),

                // Adhaar Number Field
                AdhaarNumberFieldWidget(
                    adhaarController: controller.adhaarController),

                // Shop Name Field
                FieldWidget(
                    controller: controller.shopNameController,
                    label: 'Shop name',
                    request: 'Please enter your Shop Name'),
                // Shop Location Field
                FieldWidget(
                    controller: controller.shopLocationController,
                    label: 'Shop Location',
                    request: 'Please enter your Shop Location'),

                // Submit Button
                ElevatedButton(
                  onPressed: () => controller.submitForm(context),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.green.shade400),
                      minimumSize: const WidgetStatePropertyAll(Size(150, 60)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: 'Submit'.extenTextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontfamily: Appfonts.appFontFamily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
