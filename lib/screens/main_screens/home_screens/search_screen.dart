import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/search_screen_controller/search_page_controller.dart';
import 'package:fish_and_meat_app/helpers/get_search_products.dart';
import 'package:fish_and_meat_app/helpers/scroll_listener.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/search_results.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/moving_carousel.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/recent_searches_list.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _searchEditingController =
      Get.put(TextEditingController());
  final SearchPageController _searchPageController =
      Get.put(SearchPageController());
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
                            _searchPageController.pageIndex.value = 0;
                            _searchPageController.continuationToken.value = "";
                          } else {
                            _searchPageController.pageIndex.value = 1;
                          }
                          getSearchProducts(storeContinuationToken: false);
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
                  index: _searchPageController.pageIndex.value,
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
                              fontSize: Appfontsize.headerFontSize,
                              fontFamily: Appfonts.appFontFamily,
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
                              fontSize: Appfontsize.headerFontSize,
                              fontFamily: Appfonts.appFontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RecentSearchesList(),
                      ],
                    ),
                    _searchPageController.queryItems.isEmpty
                        ? const Center(
                            child: Text("No search results found."),
                          )
                        : ListView(
                            controller: _scrollController2,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    _searchPageController.queryItems.length,
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
                                            "${Globals.imagePath}\\${_searchPageController.queryItems[index].image}",
                                            fit: BoxFit
                                                .cover, // Ensure the image covers the circle
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _searchPageController
                                                    .queryItems[index].title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                _searchPageController
                                                    .queryItems[index]
                                                    .description,
                                                style: const TextStyle(
                                                    color: Colors.grey),
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
                              _searchPageController.hasNextPage.value
                                  ? TextButton(
                                      onPressed: () {
                                        Get.to(() => SearchResults());
                                      },
                                      child: const Text(
                                        "Search more",
                                        style: TextStyle(fontSize: 18),
                                      ))
                                  : const SizedBox(),
                            ],
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
