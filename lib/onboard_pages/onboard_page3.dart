import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class OnboardPage3 extends StatelessWidget {
  const OnboardPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://plus.unsplash.com/premium_photo-1681589451969-753d5af2c2d4?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover)),
      child: Align(
        alignment: const Alignment(-0.9, 0.3),
        child: 'Save More'.extenTextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
