import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double discount;
  final double totalAmount;
  final int totalCheckOut;
  final double roundOff;
  final bool couponApplied;
  OrderSummaryWidget(
      {super.key,
      required this.discount,
      required this.totalCheckOut,
      required this.couponApplied,
      required this.totalAmount,
      required this.roundOff});
  final CartItemsListController _cartItemsListController = Get.find();
  final CheckoutPriceController _checkoutPriceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Appcolor.itemBackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: Appcolor.primaryColor),
              const SizedBox(width: 8),
              'Order Summary'.extenTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Appfontsize.regular16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('items x ${_cartItemsListController.cartItems.length}'),
              Text(
                "\$${_checkoutPriceController.totalCheckoutPrice.value}",
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Fee'),
              Row(
                children: [
                  '\$30'.extenTextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                  const SizedBox(width: 10),
                  'Free'.extenTextStyle(
                      fontWeight: FontWeight.w500, color: Colors.green),
                ],
              ),
            ],
          ),
          if (couponApplied) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Discount'.extenTextStyle(),
                "-\$${discount.toStringAsFixed(2)}"
                    .extenTextStyle(color: Colors.green),
              ],
            ),
          ],
          const SizedBox(height: 8),
          if (roundOff > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Round off'.extenTextStyle(),
                "-\$${roundOff.toStringAsFixed(2)}"
                    .extenTextStyle(color: Colors.green),
              ],
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Total'.extenTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Appfontsize.medium18,
              ),
              "\$$totalCheckOut.00".extenTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Appcolor.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
