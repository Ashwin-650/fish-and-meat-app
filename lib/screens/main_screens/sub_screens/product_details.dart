import 'dart:convert';

import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final String productID = Get.arguments;
  ProductDetails? productDetails; // Change to nullable ProductDetails
  double _rating = 0;
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 50) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void init() async {
    final response = await ApiService.getProduct(
        token: await Globals.loginToken, id: productID);
    final responseData = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      setState(() {
        productDetails = ProductDetails.fromJson(responseData["product"]);
        _rating = responseData["rating"].toDouble();
      });
    }
  }

  Color _getRatingColor(double rating) {
    if (rating < 2.0) return Colors.red;
    if (rating < 4.0) return Colors.orange;
    return Colors.green;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isFavorite ? 'Added to favorites!' : 'Removed from favorites'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Sharing product...'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: productDetails == null // Null check for productDetails
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show a loading indicator while waiting
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Image with Gradient Overlay
                        Stack(
                          children: [
                            Hero(
                              tag: productDetails!.image,
                              child: Container(
                                height: 350,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${Globals.imagePath}\\${productDetails!.image}"),
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                          Icons.image_not_supported,
                                          size: 50),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Rating Badge
                            Positioned(
                              right: 20,
                              bottom: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _getRatingColor(_rating),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _rating.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, -3),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Price Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetails!.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Appfonts.appFontFamily,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Appcolor.bottomBarColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "₹${productDetails!.price}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolor.bottomBarColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Expandable Description Section
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    initiallyExpanded: false,
                                    onExpansionChanged: (expanded) {
                                      setState(() {
                                        _isDescriptionExpanded = expanded;
                                      });
                                    },
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    title: Row(
                                      children: [
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Appfonts.appFontFamily,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Appcolor.bottomBarColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            _isDescriptionExpanded
                                                ? "Collapse"
                                                : "Read more",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Appcolor.bottomBarColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      _isDescriptionExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Appcolor.bottomBarColor,
                                    ),
                                    childrenPadding: EdgeInsets.zero,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        child: Text(
                                          productDetails!.description,
                                          style: TextStyle(
                                            fontSize: Appfontsize.regular16,
                                            color: Colors.grey[700],
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              // Quantity Selector
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontSize: Appfontsize.regular16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Appfonts.appFontFamily,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _decrementQuantity();
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey[300]!),
                                            ),
                                            child: const Icon(Icons.remove,
                                                size: 16),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey[300]!),
                                          ),
                                          child: Text(
                                            _quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: Appfontsize.regular16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _incrementQuantity();
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Appcolor.bottomBarColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.add,
                                                size: 16, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: Appfonts.appFontFamily,
                            ),
                          ),
                          Text(
                            "₹${((productDetails!.price) * (productDetails!.quantity ?? 0)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.bottomBarColor,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Added to cart!'),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.bottomBarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_outlined,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: Appfontsize.regular16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: Appfonts.appFontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
