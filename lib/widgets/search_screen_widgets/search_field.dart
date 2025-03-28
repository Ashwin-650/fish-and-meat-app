import 'package:fish_and_meat_app/widgets/search_screen_widgets/search_items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController _searchEditingController =
      Get.put(TextEditingController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        Get.to(const SearchItemsList(), transition: Transition.downToUp);
      },
      controller: _searchEditingController,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white70,
        prefixIcon: const Icon(
          Icons.search,
        ),
        hintText: 'Search for items...',
        hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
      ),
    );
  }
}
