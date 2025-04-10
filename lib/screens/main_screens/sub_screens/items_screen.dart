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
        final pagination = responseData["pagination"];

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
              final imageUrl = '${Globals.imagePath}/${item.image}';

              return InkWell(
                onTap: () => Get.to(
                  () => ProductDetailPage(),
                  arguments: item.id,
                ),
                child: Card(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🖼 Image section
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 📝 Text section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: Appfontsize.regular16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: Appfontsize.small14,
                                    color: Colors.black54),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '₹${item.price}',
                                    style: TextStyle(
                                      fontSize: Appfontsize.regular16,
                                      color: item.offerPrice != null
                                          ? Colors.grey
                                          : Colors.black,
                                      decoration: item.offerPrice != null
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  if (item.offerPrice != null) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '₹$item.offerPrice',
                                      style: const TextStyle(
                                        fontSize: Appfontsize.regular16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
