import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class PlaceorderButtonWidget extends StatelessWidget {
  const PlaceorderButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: 'Place Order'.extenTextStyle(
            fontSize: Appfontsize.medium18, fontfamily: Appfonts.appFontFamily),
      ),
    );
  }
}
