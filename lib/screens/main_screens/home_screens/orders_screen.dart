import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/controllers/orders_items_list_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/order_screen_widgets/orders_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersItemsListController _cartItemsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
          backgroundColor: Appcolor.appbargroundColor,
          title: 'Orders'
              .extenTextStyle(fontWeight: FontWeight.w700, fontsize: 24)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartItemsListController.cartItems.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => OrdersListTile(
                    order: _cartItemsListController.cartItems[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
