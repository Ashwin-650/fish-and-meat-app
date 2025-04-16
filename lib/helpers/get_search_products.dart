import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/search_screen_controller/search_page_controller.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController _searchEditingController = Get.find();
final SearchPageController _searchPageController = Get.find();

void getSearchProducts({bool storeContinuationToken = true}) async {
  final token = await SharedPreferencesServices.getValue(Globals.apiToken, "");
  if (token != "" && _searchEditingController.text.isNotEmpty) {
    final response = await ApiService.getProducts(
        token: token,
        query: _searchEditingController.text,
        cursor: _searchPageController.continuationToken.value);
    if (response != null && response.statusCode == 200) {
      final responseData = json.decode(response.body)["data"];
      final products = responseData["products"];
      final pagination = responseData["pagination"];
      if (storeContinuationToken) {
        _searchPageController.continuationToken.value =
            pagination["nextCursor"] ?? "";
      }
      _searchPageController.hasNextPage.value = pagination["hasNextPage"];
      _searchPageController.queryItems.value = (products as List)
          .map((productJson) => ProductDetails.fromJson(productJson))
          .toList();
    }
  } else {
    _searchPageController.clearList();
  }
}
