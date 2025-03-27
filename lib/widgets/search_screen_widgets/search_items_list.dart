import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';

class SearchItemsList extends StatefulWidget {
  const SearchItemsList({super.key});

  @override
  State<SearchItemsList> createState() => _SearchItemsListState();
}

class _SearchItemsListState extends State<SearchItemsList> {
  final TextEditingController textEditingController = TextEditingController();
  List<ProductDetails> queryItems = [];
  bool isSuggestionVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search for meats, fishes & shop",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Stack(
              children: [
                Visibility(
                  visible: isSuggestionVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CarouselSlider(
                      items: [
                        Text(
                          "Try 'Boneless chicken'",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                        Text(
                          "Try 'Red meat'",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                        Text(
                          "Try 'Prawns'",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                        Text(
                          "Try 'Milk'",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 54,
                        scrollDirection: Axis.vertical,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  onChanged: (value) async {
                    setState(() {
                      if (textEditingController.text.isEmpty) {
                        isSuggestionVisible = true;
                      } else {
                        isSuggestionVisible = false;
                      }
                    });
                    final token = await SharedPreferencesServices.getValue(
                        Globals.apiToken, "");
                    if (token != "" && textEditingController.text.isNotEmpty) {
                      final response = await ApiService.getProducts(
                          token: token, query: textEditingController.text);
                      if (response != null && response.statusCode == 200) {
                        setState(() {
                          queryItems = (json.decode(response.body) as List)
                              .map((productJson) =>
                                  ProductDetails.fromJson(productJson))
                              .toList();
                        });
                      }
                    } else {
                      setState(() {
                        queryItems = [];
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white10,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: queryItems.length,
              itemBuilder: (ctx, index) {
                return Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 70,
                      height: 70,
                      child: ClipOval(
                        // Clip the image into a circle
                        child: Image.network(
                          "${Globals.imagePath}\\${queryItems[index].image}",
                          fit: BoxFit
                              .cover, // Ensure the image covers the circle
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            queryItems[index].title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            queryItems[index].description,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
