import 'package:add_to_cart_animated_button/add_to_cart.dart';
import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
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

  final HomeController controller = Get.find();
  final CartItemsListController _cartItemsListController = Get.find();
  final CheckoutPriceController _checkoutPriceController = Get.find();

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
                // final buttonText = _cartItemsListController.cartItems.any(
                //         (item) => item.productId == controller.items[index].id)
                //     ? "Added"
                //     : "Add";
                // final color = _cartItemsListController.cartItems.any(
                //         (item) => item.productId == controller.items[index].id)
                //     ? Appcolor.secondaryColor
                //     : Appcolor.primaryColor;
                // return ElevatedButton(
                //   onPressed: _cartItemsListController.cartItems.any((item) =>
                //           item.productId == controller.items[index].id)
                //       ? null
                //       : _addToCart,
                //   style: ButtonStyle(
                //     backgroundColor: WidgetStatePropertyAll(color),
                //     foregroundColor: const WidgetStatePropertyAll(Colors.white),
                //   ),
                //   child: buttonText.extenTextStyle(
                //     color: Colors.white,
                //     fontSize: Appfontsize.medium18,
                //     fontWeight: FontWeight.bold,
                //     fontfamily: Appfonts.appFontFamily,
                //   ),
                // );
                final cartItemIndex = _cartItemsListController.cartItems
                    .indexWhere(
                        (item) => item.productId == controller.items[index].id);
                return AddToCart(
                  value: cartItemIndex >= 0
                      ? _cartItemsListController
                              .cartItems[cartItemIndex].quantity ??
                          0
                      : 0,
                  onIncrement: (newValue) async {
                    await _addToCart();
                  },
                  onDecrement: (newValue) async {
                    await _removeFromCart(
                        _cartItemsListController.cartItems[cartItemIndex].id);
                  },
                  maxValue: controller.items[index].stock!,
                  width: 80,
                  height: 40,
                  initialBoxDecoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  counterBoxDecoration: BoxDecoration(
                      color: Appcolor.secondaryColor,
                      borderRadius: BorderRadius.circular(15)),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  _addToCart() async {
    final response = await ApiService.addToCart(
      token: await Globals.loginToken,
      item: controller.items[index],
    );
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      getItemFromCart(
          checkoutPriceController: _checkoutPriceController,
          cartItemsListController: _cartItemsListController);
      Get.showSnackbar(
        const GetSnackBar(
          message: "Added to cart",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  _removeFromCart(id) async {
    final response = await ApiService.removeFromCart(
      token: await Globals.loginToken,
      id: id,
    );
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      getItemFromCart(
          checkoutPriceController: _checkoutPriceController,
          cartItemsListController: _cartItemsListController);
      Get.showSnackbar(
        const GetSnackBar(
          message: "Removed from cart",
          backgroundColor: Colors.yellow,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
