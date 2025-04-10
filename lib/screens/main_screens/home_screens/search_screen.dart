import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/search_screen_controller/query_items_controller.dart';
import 'package:fish_and_meat_app/controllers/search_screen_controller/search_page_index_controller.dart';
import 'package:fish_and_meat_app/helpers/scroll_listener.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/moving_carousel.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/recent_searches_list.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _searchEditingController =
      Get.put(TextEditingController());
  final QueryItemsController _queryItemsController =
      Get.put(QueryItemsController());
  final SearchPageIndexController _searchPageIndexController =
      Get.put(SearchPageIndexController());
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() => scrollListener(_scrollController));
      _scrollController2.addListener(() => scrollListener(_scrollController2));
    });
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Appcolor.bottomBarColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey[600]!)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        onChanged: (value) async {
                          if (_searchEditingController.text.isEmpty) {
                            _searchPageIndexController.pageIndex.value = 0;
                          } else {
                            _searchPageIndexController.pageIndex.value = 1;
                          }
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
                              _queryItemsController.queryItems.value =
                                  (json.decode(response.body)["data"] as List)
                                      .map((productJson) =>
                                          ProductDetails.fromJson(productJson))
                                      .toList();
                            }
                          } else {
                            _queryItemsController.clearList();
                          }
                        },
                        controller: _searchEditingController,
                        style: const TextStyle(
                          fontSize: Appfontsize.high20,
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
                              fontSize: Appfontsize.medium18,
                              fontWeight: FontWeight.bold),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14.0),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                    child: MovingCarousel(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: _searchPageIndexController.pageIndex.value,
                  children: [
                    ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Suggested",
                            style: TextStyle(
                              fontSize: Appfontsize.medium18,
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
                              fontSize: Appfontsize.medium18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RecentSearchesList(),
                      ],
                    ),
                    ListView.builder(
                      controller: _scrollController2,
                      shrinkWrap: true,
                      itemCount: _queryItemsController.queryItems.length,
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
                                  "${Globals.imagePath}\\${_queryItemsController.queryItems[index].image}",
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the circle
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _queryItemsController
                                          .queryItems[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      _queryItemsController
                                          .queryItems[index].description,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
