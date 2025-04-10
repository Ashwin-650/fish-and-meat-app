import 'dart:convert';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class VendorMode extends StatefulWidget {
  const VendorMode({super.key});

  @override
  _VendorModeState createState() => _VendorModeState();
}

class _VendorModeState extends State<VendorMode> {
  List<ProductDetails> products = [];
  bool isLoading = true; // Loading state
  bool isDeleting = false;
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
        final responseBody = jsonDecode(response.body);
        final List responseData = responseBody["data"];

        setState(() {
          products = responseData
              .map((json) => ProductDetails.fromJson(json))
              .toList();
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

  Future<void> _deleteProduct(String productId) async {
    setState(() {
      isDeleting = true;
    });

    String? token = await SharedPreferencesServices.getValue(
        Globals.apiToken, ''); // Get token from storage

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Authentication error. Please login again.')),
      );
      setState(() => isDeleting = false);
      return;
    }

    try {
      // Make the API call to delete the product
      final http.Response response = await ApiService.deleteProduct(
        id: productId,
        token: token,
      );
      // print(token);

      if (response.statusCode == 200) {
        // If successful, remove product from local list
        setState(() {
          products.removeWhere((product) => product.id == productId);
          isDeleting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product removed successfully')),
        );
      } else {
        // Handle error responses
        final responseData = jsonDecode(response.body);

        String errorMessage =
            responseData['message'] ?? 'Failed to delete product';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        setState(() => isDeleting = false);
        print(response);
      }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
      setState(() => isDeleting = false);
    }
  }

//
  void _showDeleteConfirmation(String productId, String productName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "$productName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteProduct(productId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Products'.extenTextStyle(),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await Get.to(() => ProductAddVendor());
                if (result == true) {
                  _fetchProducts();
                }
              }),
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
                                product.image.startsWith('http')
                                    ? product.image
                                    : '${Globals.imagePath}/${product.image}',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                              const SizedBox(height: 12),
                              product.title.extenTextStyle(
                                fontSize: Appfontsize.medium18,
                                fontWeight: FontWeight.bold,
                              ),
                              if (product.description.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: product.description.extenTextStyle(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Category: ${product.category}'),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => _showDeleteConfirmation(
                                        product.id,
                                        product.title,
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
