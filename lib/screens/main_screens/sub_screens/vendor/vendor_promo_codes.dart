import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/create_promo_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPromoCodes extends StatelessWidget {
  const VendorPromoCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Promo codes".extenTextStyle(
          color: Appcolor.primaryColor.value,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreatePromoCode());
            },
            icon: const Icon(Icons.add_circle_outline),
          )
        ],
      ),
    );
  }
}
