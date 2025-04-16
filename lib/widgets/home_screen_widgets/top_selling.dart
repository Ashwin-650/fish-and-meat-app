import 'package:add_to_cart_animated_button/add_to_cart.dart';
import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/controllers/home_page_controllers/home_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/helpers/get_items_from_cart.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSelling extends StatelessWidget {
  final int index;
  TopSelling({
    super.key,
    required this.index,
  });

  final CartItemsListController _cartItemsListController = Get.find();
  final CheckoutPriceController _checkoutPriceController = Get.find();
  final HomeController controller = Get.find();
  final CartScreenController _cartScreenController =
      Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Appcolor.backgroundColor,
        ),
        width: 150,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${Globals.imagePath}\\${controller.items[index].image}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                controller.items[index].title.extenTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Appfontsize.medium18,
                    textAlign: TextAlign.center)
              ],
            ),
            Positioned(
              top: 20,
              right: 10,
              child: Obx(() {
                final item = controller.items[index];

                return AddToCart(
                  width: 80,
                  height: 40,
                  counterBoxDecoration: BoxDecoration(
                    color: Appcolor.secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  initialBoxDecoration: BoxDecoration(
                    color: Appcolor.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  value: index >= _cartItemsListController.cartItems.length
                      ? 0
                      : _cartItemsListController.cartItems[index].quantity ?? 0,
                  onIncrement: (newValue) async {
                    _cartScreenController.increment(item.id);
                    final response = await ApiService.addToCart(
                      token: await Globals.loginToken,
                      item: item,
                    );
                    if (response != null &&
                        (response.statusCode == 200 ||
                            response.statusCode == 201)) {
                      getItemFromCart(
                          cartItemsListController: _cartItemsListController,
                          checkoutPriceController: _checkoutPriceController);
                      Get.showSnackbar(const GetSnackBar(
                        message: "Added to cart",
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                  onDecrement: (newValue) async {
                    final response = await ApiService.removeFromCart(
                      token: await Globals.loginToken,
                      id: _cartItemsListController.cartItems[index].id,
                    );
                    if (response != null &&
                        (response.statusCode == 200 ||
                            response.statusCode == 201)) {
                      getItemFromCart(
                          cartItemsListController: _cartItemsListController,
                          checkoutPriceController: _checkoutPriceController);
                      Get.showSnackbar(const GetSnackBar(
                        message: "Removed from cart",
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                  maxValue: item.stock!,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
