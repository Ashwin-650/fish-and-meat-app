import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listcategory = Get.arguments;

    List<List<String>> displayText = [
      [
        'Fresh',
        'Fresh1',
        'Fresh2',
        'Fresh3',
      ],
      [
        'meat ',
        'meat 1',
        'meat 2',
        'meat 3',
      ]
    ];

    String showText =
        displayText[listcategory["category"]][listcategory["index"]];

    return Scaffold(
      body: Center(
        child: Text(showText),
      ),
    );
  }
}
