import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:flutter/material.dart';

class PlaceorderButtonWidget extends StatelessWidget {
  const PlaceorderButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
      width: double.infinity,
      child: CommonButton(onPress: onTap, buttonText: "Place Order"),
    );
  }
}
