import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
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
    print('$listcategory');
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

    Future<List<dynamic>> fetchItems() async {
      String token =
          await SharedPreferencesServices.getValue(Globals.apiToken, '');
      final response = await ApiService.getItemsCategory(
          token: token, category: categoryPassed);
      print(listcategory.runtimeType);
      print(categoryPassed);
      if (response is http.Response && response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Adjust this key based on your API response
      } else {
        throw Exception('Failed to load items');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(categoryPassed)),
      body: FutureBuilder<List<dynamic>>(
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
              final name = item['title'] ?? 'No name';
              final description = item['description'] ?? '';
              final price = item['price']?.toString() ?? 'N/A';
              final offerPrice =
                  item['offerprice']?.toString(); // null if not available
              final imageUrl =
                  '${Globals.imagePath}/${item['image']}'; // change key if needed
              print(item['offerprice']);
              print(
                  'Offer price for ${item['title']}: ${item['offerPrice'] ?? "Not provided"}');

              return InkWell(
                onTap: () => Get.to(() => ProductDetailPage(), arguments: {
                  'image': imageUrl,
                  'title': name,
                  'description': description,
                  'price': price,
                  'offerPrice': offerPrice
                }),
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
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
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                description,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '₹$price',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: offerPrice != null
                                          ? Colors.grey
                                          : Colors.black,
                                      decoration: offerPrice != null
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  if (offerPrice != null) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '₹$offerPrice',
                                      style: const TextStyle(
                                        fontSize: 15,
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
