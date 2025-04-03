import 'dart:convert';
import 'dart:io';

import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final String id;
  final String title;
  final String? description;
  final String imagePath; // Change File to String (URL or local path)
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
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      availableLocations: json['availableLocations'] ?? '',
      category: json['category'] ?? '',
      offerPrice:
          json['offerPrice'] != null ? (json['offerPrice']).toDouble() : null,
      stock: json['stock'] ?? 0,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // Get token from storage

    if (token == null) {
      print("Error: No token found.");
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await ApiService.getFromVendor(token: token);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];

        setState(() {
          products = data.map((json) => Product.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        setState(() => isLoading = false);
      }
    } catch (error) {
      print("API Error: $error");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
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
              ? const Center(
                  child: Text('No products available! Tap + to add a product.'),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            product.imagePath.startsWith('http')
                                ? Image.network(
                                    product.imagePath,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(product.imagePath),
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            const SizedBox(height: 12),
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (product.description != null &&
                                product.description!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(product.description!),
                              ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Price: ₹${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                if (product.offerPrice != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Offer: ₹${product.offerPrice!.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Category: ${product.category}'),
                            const SizedBox(height: 4),
                            Text('Stock: ${product.stock} units'),
                            const SizedBox(height: 4),
                            Text('Available in: ${product.availableLocations}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
