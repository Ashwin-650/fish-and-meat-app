import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final Function() onPressed;
  const SeeAllButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size(80, 40)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed)) {
              return Appcolor.secondaryColor;
            }
            return Appcolor.primaryColor;
          }),
          foregroundColor: const WidgetStatePropertyAll(Colors.black)),
      onPressed: onPressed,
      child: 'See all'.extenTextStyle(
          color: Colors.white,
          fontSize: Appfontsize.small14,
          fontfamily: Appfonts.appFontFamily,
          fontWeight: FontWeight.bold),
    );
  }
}
