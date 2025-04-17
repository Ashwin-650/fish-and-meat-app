import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Function() onPress;
  const CommonButton(
      {super.key, required this.onPress, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress, // <-- remove the arrow function
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolor.primaryColor.value,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Appcolor.secondaryColor; // Custom pressed color
            }
            return null; // Default behavior
          },
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: Appfontsize.regular16),
      ),
    );
  }
}
