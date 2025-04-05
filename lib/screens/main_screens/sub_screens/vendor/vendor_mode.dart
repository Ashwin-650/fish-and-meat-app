import 'dart:convert';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String title;
  final String? description;
  final String imagePath;
  final double price;
  final String availableLocations;
  final String category;
  final double? offerPrice;
  final int stock;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.imagePath,
    required this.price,
    required this.availableLocations,
    required this.category,
    this.offerPrice,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '', // Ensuring ID is always a string
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      imagePath: json['image']?.toString() ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      category: json['category']?.toString() ?? '',
      offerPrice: (json['offerPrice'] is num)
          ? (json['offerPrice'] as num).toDouble()
          : null,
      stock: json['stock'] is int ? json['stock'] : 0, availableLocations: '',
    );
  }
}

class VendorMode extends StatefulWidget {
  const VendorMode({super.key});

  @override
  _VendorModeState createState() => _VendorModeState();
}

class _VendorModeState extends State<VendorMode> {
  List<Product> products = [];
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Call API on startup
  }

  Future<void> _fetchProducts() async {
    String? token = await SharedPreferencesServices.getValue(
        Globals.apiToken, ''); // Get token from storage

    if (token == null) {
      // print("Error: No token found.");
      setState(() => isLoading = false);
      return;
    }

    try {
      final http.Response response =
          await ApiService.getFromVendor(token: token);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          products = data.map((json) => Product.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (error) {
      // print("API Error: $error");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Products'.extenTextStyle(),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Get.to(
                    () => ProductAddVendor(),
                  )),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(
                  child: 'No products available! Tap + to add a product.'
                      .extenTextStyle(),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product.imagePath.startsWith('http')
                                    ? product.imagePath
                                    : '${Globals.imagePath}/${product.imagePath}',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                              const SizedBox(height: 12),
                              product.title.extenTextStyle(
                                fontsize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              if (product.description != null &&
                                  product.description!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: product.description!.extenTextStyle(
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 3),
                                ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  'Price: ₹${product.price.toStringAsFixed(2)}'
                                      .extenTextStyle(
                                          fontWeight: FontWeight.bold),
                                  if (product.offerPrice != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child:
                                          'Offer: ₹${product.offerPrice!.toStringAsFixed(2)}'
                                              .extenTextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('Category: ${product.category}'),
                              const SizedBox(height: 4),
                              Text('Stock: ${product.stock} units'),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
