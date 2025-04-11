import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailpageController extends GetxController {
  final String productID = Get.arguments;
  Rx<ProductDetails?> productDetails = Rxn<ProductDetails>();
  RxInt quantity = 1.obs;
  RxBool isFavorite = false.obs;
  RxInt rating = 3.obs;
  RxBool isDescriptionExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void incrementQuantity() {
    if (quantity < 50) {
      quantity++;
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  Color getRatingColor(double rating) {
    if (rating < 2.0) return Colors.red;
    if (rating < 4.0) return Colors.orange;
    return Colors.green;
  }

  void toggleFavorite(BuildContext context) {
    isFavorite.value = isFavorite.value;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite.value
            ? 'Added to favorites!'
            : 'Removed from favorites'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void init() async {
    final response = await ApiService.getProduct(
        token: await Globals.loginToken, id: productID);
    final responseData = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      productDetails.value = ProductDetails.fromJson(responseData["product"]);
      rating = responseData["rating"].toDouble();
    }
  }
}
