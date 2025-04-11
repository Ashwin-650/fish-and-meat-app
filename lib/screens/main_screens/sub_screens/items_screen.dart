import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listcategory = Get.arguments;
    List<List<String>> displayCategory = [
      [
        'Fresh water fish',
        'salt water fish',
        'shell fish',
        'prawns',
      ],
      [
        'chicken',
        'beef',
        'mutton',
        'pork',
      ]
    ];
    int categoryIndex = listcategory["category"]! as int;
    int itemIndex = (listcategory["index"]!) as int;

    String categoryPassed = displayCategory[categoryIndex][itemIndex];

    Future<List<ProductDetails>> fetchItems() async {
      String token =
          await SharedPreferencesServices.getValue(Globals.apiToken, '');
      final response = await ApiService.getItemsCategory(
          token: token, category: categoryPassed);

      if (response is http.Response && response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody["data"];
        final products = responseData["products"];
        // final pagination = responseData["pagination"];

        return (products as List)
            .map((json) => ProductDetails.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load items');
      }
    }

    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
          backgroundColor: Appcolor.appbargroundColor,
          title: categoryPassed.extenTextStyle(
              fontfamily: Appfonts.appFontFamily)),
      body: FutureBuilder<List<ProductDetails>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return InkWell(
                  onTap: () => Get.to(
                        () => const ProductDetailPage(),
                        arguments: item.id,
                      ),
                  child: ListItemWidget(item: item));
            },
          );
        },
      ),
    );
  }
}
