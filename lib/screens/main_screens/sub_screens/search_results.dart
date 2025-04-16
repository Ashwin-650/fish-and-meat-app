import 'package:fish_and_meat_app/controllers/search_screen_controller/search_page_controller.dart';
import 'package:fish_and_meat_app/helpers/get_search_products.dart';
import 'package:fish_and_meat_app/widgets/list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  SearchResults({super.key});

  final SearchPageController _searchPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getSearchProducts();
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () {
            final items = _searchPageController.queryItems;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListItemWidget(item: items[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
