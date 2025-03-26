import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String iconText;
  const SocialButton({super.key, required this.iconText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFDDDDDD),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          iconText,
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}
