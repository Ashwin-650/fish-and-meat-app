import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
          backgroundColor: Appcolor.appbargroundColor,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'What are you looking for...',
                  prefixIcon: const Icon(Icons.search)),
            ),
          )),
    );
  }
}
