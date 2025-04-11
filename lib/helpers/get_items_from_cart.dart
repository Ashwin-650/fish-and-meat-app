import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';

void getItemFromCart(
    {required CheckoutPriceController checkoutPriceController,
    required CartItemsListController cartItemsListController}) async {
  final response =
      await ApiService.getFromCart(token: await Globals.loginToken);
  if (response != null && response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);

    final responseData = responseBody["data"];
    print(responseData);
    final items = ((responseData) as List)
        .map((productJson) => ProductDetails.fromJson(productJson))
        .toList();
    cartItemsListController.setItems(items);
    checkoutPriceController.resetPrice();
    for (var item in items) {
      checkoutPriceController.addPrice(item.price * item.quantity!);
    }
  }
}
