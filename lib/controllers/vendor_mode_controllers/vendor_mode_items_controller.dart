import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as https;

class VendorModeItemsController extends GetxController {
  RxList<ProductDetails> products = RxList([]);
  RxBool isLoading = true.obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    print("FETCHING PRODUCTS...");
    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null) {
      isLoading.value = false;
      print("No token found");
      return;
    }

    try {
      print("Sending API request to getFromVendor...");
      final https.Response response =
          await ApiService.getFromVendor(token: token);
      print("API response received");
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List responseData = responseBody["data"];

        products.value =
            responseData.map((json) => ProductDetails.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (error) {
      print(error);
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId, BuildContext context) async {
    isDeleting.value = true;

    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null) {
      _showSnackBar(context, 'Authentication error. Please login again.',
          isError: true);
      isDeleting.value = false;
      return;
    }

    try {
      final https.Response response = await ApiService.deleteProduct(
        id: productId,
        token: token,
      );

      if (response.statusCode == 200) {
        products.removeWhere((product) => product.id == productId);
        isDeleting.value = false;

        _showSnackBar(context, 'Product removed successfully');
      } else {
        final responseData = jsonDecode(response.body);
        String errorMessage =
            responseData['message'] ?? 'Failed to delete product';
        _showSnackBar(context, errorMessage, isError: true);
        isDeleting.value = false;
      }
    } catch (error) {
      _showSnackBar(context, 'Error: ${error.toString()}', isError: true);
      isDeleting.value = false;
    }
  }

  void _showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade800 : Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
