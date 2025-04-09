import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class OnboardPage1 extends StatelessWidget {
  const OnboardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1634932515818-7f9292c4e149?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            'High Quality'.extenTextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
