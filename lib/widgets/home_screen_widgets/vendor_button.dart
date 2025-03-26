import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorButton extends StatelessWidget {
  const VendorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: 'Want to sell your product ?'.extenTextStyle(
                          fontWeight: FontWeight.bold, fontsize: 25),
                    ),
                    'Be a Vendor'.extenTextStyle(
                        fontsize: 34,
                        color: Appcolor.appbargroundColor,
                        fontWeight: FontWeight.bold),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/003/105/042/non_2x/shopkeeper-and-vendor-vector.jpg'),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const VendorSignUpScreen());
                      },
                      style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size(200, 50)),
                          backgroundColor: WidgetStatePropertyAll(
                              Appcolor.appbargroundColor),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                      child: 'Sign Up'.extenTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 16),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: 'Become a Vendor'.extenTextStyle(
          fontsize: 20,
          fontfamily: Appfonts.appFontFamily,
          color: Colors.white),
    );
  }
}
