import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:get/get.dart';

class CartItemsListController extends GetxController {
  // Define the cartItems as RxList
  var cartItems = RxList<ProductDetails>([]);
  var totalCheckoutPrice = 0.0.obs;

  void getItemFromCart() async {
    final response =
        await ApiService.getFromCart(token: await Globals.loginToken);
    if (response != null && response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final responseData = responseBody["data"];
      final items = ((responseData) as List)
          .map((productJson) => ProductDetails.fromJson(productJson))
          .toList();
      cartItems.value = items;
      totalCheckoutPrice.value == 0.0;
      for (var item in items) {
        totalCheckoutPrice.value += item.price * item.quantity!;
      }
    }
  }

  // Method to reset the counter (empty the cart)
  void resetCounter() {
    cartItems.clear(); // Clears the RxList
  }
}
