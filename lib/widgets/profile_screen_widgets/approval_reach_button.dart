import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_approval_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalReachButton extends StatelessWidget {
  const ApprovalReachButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Get.to(() => const VendorApprovalScreen()),
        style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(200, 50)),
            backgroundColor: WidgetStatePropertyAll(Colors.green.shade400),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: 'Vendor Profile'.extenTextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Appfontsize.regular16));
  }
}
