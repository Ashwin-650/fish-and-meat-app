import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Function onPress;
  const CommonButton(
      {super.key, required this.onPress, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPress(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
