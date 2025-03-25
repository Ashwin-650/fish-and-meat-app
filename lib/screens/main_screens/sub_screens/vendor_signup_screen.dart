import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class VendorSignupScreen extends StatelessWidget {
  const VendorSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Sign Up'.extenTextStyle(),
      ),
    );
  }
}
