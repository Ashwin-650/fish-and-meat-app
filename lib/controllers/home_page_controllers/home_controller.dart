import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/helpers/scroll_listener.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var items = <ProductDetails>[].obs;
  final ScrollController _scrollController = Get.find();

  @override
  void onInit() {
    super.onInit();
    init();
    _scrollController.addListener(() => scrollListener(_scrollController));
  }

  @override
  void onClose() {
    super.onClose();
    _scrollController.dispose(); // Dispose the controller to avoid memory leaks
  }

  init() async {
    final response =
        await ApiService.getProducts(token: await Globals.loginToken);
    if (response != null && response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final responseData = responseBody["data"];

      final List<dynamic> productList = responseData;

      items.value = productList
          .map((productJson) => ProductDetails.fromJson(productJson))
          .toList();
    }
  }
}
