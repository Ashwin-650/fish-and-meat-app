import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/moving_carousel.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/recent_searches_list.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchEditingController =
      Get.put(TextEditingController());
  List<ProductDetails> queryItems = [];
  int searchPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
        child: Container(
          color: Appcolor.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Appcolor.bottomBarColor,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.grey[300]!)),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: TextField(
                            onChanged: (value) async {
                              setState(() {
                                if (_searchEditingController.text.isEmpty) {
                                  searchPageIndex = 0;
                                } else {
                                  searchPageIndex = 1;
                                }
                              });
                              final token =
                                  await SharedPreferencesServices.getValue(
                                      Globals.apiToken, "");
                              if (token != "" &&
                                  _searchEditingController.text.isNotEmpty) {
                                final response = await ApiService.getProducts(
                                    token: token,
                                    query: _searchEditingController.text);
                                if (response != null &&
                                    response.statusCode == 200) {
                                  setState(() {
                                    queryItems =
                                        (json.decode(response.body) as List)
                                            .map((productJson) =>
                                                ProductDetails.fromJson(
                                                    productJson))
                                            .toList();
                                  });
                                }
                              } else {
                                setState(() {
                                  queryItems = [];
                                });
                              }
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
                              hintStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                            ),
                          )),
                      const SizedBox(height: 50, child: MovingCarousel()),
                    ],
                  ),
                ),
                IndexedStack(
                  index: searchPageIndex,
                  children: [
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Suggested",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100, child: SuggestionList()),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Recent Searches",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RecentSearchesList(),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    queryItems[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
