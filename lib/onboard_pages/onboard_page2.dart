import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class OnboardPage2 extends StatelessWidget {
  const OnboardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1617347454431-f49d7ff5c3b1?q=80&w=2015&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover)),
      child: Align(
        alignment: const Alignment(0, -0.5),
        child: 'Fast Delivery'.extenTextStyle(
            fontsize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.8)),
      ),
    );
  }
}
