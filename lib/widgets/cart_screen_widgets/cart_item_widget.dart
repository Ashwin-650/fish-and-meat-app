import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/helpers/get_items_from_cart.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatelessWidget {
  final ProductDetails item;
  CartItemWidget({super.key, required this.item});
  final CheckoutPriceController _checkoutPriceController = Get.find();
  final CartItemsListController _cartItemsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Appcolor.itemBackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item Image (placeholder)
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage("${Globals.imagePath}\\${item.image}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Appfontsize.regular16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Subtotal: \$${(item.price * item.quantity!).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: Appfontsize.small14,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Container(
              decoration: BoxDecoration(
                color: Appcolor.bottomBarColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final token = await Globals.loginToken;
                        final response = await ApiService.removeFromCart(
                            token: token, id: item.id);
                        if (response != null && response.statusCode == 200) {
                          getItemFromCart(
                              cartItemsListController: _cartItemsListController,
                              checkoutPriceController:
                                  _checkoutPriceController);
                        }
                      }),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final token = await Globals.loginToken;
                        final response = await ApiService.insertToCart(
                            token: token, id: item.id);
                        if (response != null && response.statusCode == 200) {
                          getItemFromCart(
                              cartItemsListController: _cartItemsListController,
                              checkoutPriceController:
                                  _checkoutPriceController);
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
