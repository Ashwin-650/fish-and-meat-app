import 'dart:convert';
import 'dart:io';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductAddVendorController extends GetxController {
  RxString selectedCategory = RxString("Chicken");
  Rxn<File> pickedImage = Rxn<File>();
// Use RxList to make it reactive
  RxList<String> availableLocations = <String>[].obs;
  Rxn<ProductDetails> seletedProduct = Rxn<ProductDetails>();

  // Method to add a pincode to the list
  void addPincode(String pincode) {
    if (pincode.isNotEmpty && !availableLocations.contains(pincode)) {
      availableLocations.add(pincode);
    }
  }

  setCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }

  void setImage(File image) {
    pickedImage.value = image;
  }

  void clearImage() {
    pickedImage.value = null;
  }

  Future<void> addProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController priceController,
    required TextEditingController offerPriceController,
    required TextEditingController stockController,
  }) async {
    if (!formKey.currentState!.validate()) return;

    if (pickedImage.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (availableLocations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one location')),
      );
      return;
    }

    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Authentication error. Please login again.')),
      );
      return;
    }

    try {
      final response = await ApiService.vendorProductAdd(
        token: token,
        title: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        availability: availableLocations.join(','),
        category: selectedCategory.value,
        offerPrice: offerPriceController.text,
        stock: stockController.text,
        image: pickedImage.value!,
      );

      final decodedResponse = jsonDecode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          decodedResponse['message'].toString().trim().toLowerCase() ==
              'product added') {
        Get.showSnackbar(const GetSnackBar(
          message: 'Product added successfully!',
        ));

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(decodedResponse['message'] ?? 'Failed to add product')),
        );
      }
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        message: 'Error: $error',
      ));
    }
  }

  Future<void> editProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String productId,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController priceController,
    required TextEditingController offerPriceController,
    required TextEditingController stockController,
    required TextEditingController pincodeController,
    required File? image,
  }) async {
    if (!formKey.currentState!.validate()) return;

    if (pickedImage.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (availableLocations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one location')),
      );
      return;
    }

    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Authentication error. Please login again.')),
      );
      return;
    }

    try {
      final http.Response response;
      if (image != null) {
        response = await ApiService.vendorProductUpdate(
            token: await Globals.loginToken,
            productId: productId,
            title: titleController.text,
            description: descriptionController.text,
            price: priceController.text,
            availability: availableLocations.toString(),
            offerPrice: offerPriceController.text,
            stock: stockController.text,
            image: image,
            category: selectedCategory.value);
      } else {
        response = await ApiService.vendorProductUpdateWithoutImage(
          token: await Globals.loginToken,
          productId: productId,
          title: titleController.text,
          description: descriptionController.text,
          price: priceController.text,
          availability: pincodeController.text,
          offerPrice: offerPriceController.text,
          stock: stockController.text,
          category: selectedCategory.value,
        );
      }

      final decodedResponse = jsonDecode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          decodedResponse['message'].toString().trim().toLowerCase() ==
              'product added') {
        Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 3),
          message: 'Product added successfully!',
        ));

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 3),
              content:
                  Text(decodedResponse['message'] ?? 'Failed to add product')),
        );
      }
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        message: 'Error: $error',
      ));
    }
  }
}
