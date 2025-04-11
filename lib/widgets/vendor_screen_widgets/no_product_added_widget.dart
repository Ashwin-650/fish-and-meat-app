import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

class NoProductAddedWidget extends StatelessWidget {
  const NoProductAddedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.inventory,
          size: 80,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 20),
        Text(
          'No products available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
            fontFamily: Appfonts.appFontFamily,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tap + to add your first product',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontFamily: Appfonts.appFontFamily,
          ),
        ),
      ],
    );
  }
}
