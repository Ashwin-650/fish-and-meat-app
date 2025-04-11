import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/orderscreen_controllers/orders_items_list_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersItemsListController ordersItemsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
          backgroundColor: Appcolor.appbargroundColor,
          title: 'Orders'.extenTextStyle(
            fontfamily: Appfonts.appFontFamily,
            fontSize: Appfontsize.appBarHeadSize,
          )),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: ordersItemsListController.cartItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade600),
                        color: Appcolor.itemBackColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Order ID: ${ordersItemsListController.cartItems[index].id}"
                              .extenTextStyle(
                                  fontSize: Appfontsize.medium18,
                                  fontWeight: FontWeight.w700),
                          ListTile(
                            horizontalTitleGap: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title:
                                "Items: ${ordersItemsListController.cartItems[index].items.length}\nPaid: \$${ordersItemsListController.cartItems[index].amount}\nDelivered to: ${ordersItemsListController.cartItems[index].address}"
                                    .toString()
                                    .extenTextStyle(
                                      fontfamily: Appfonts.appFontFamily,
                                    ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: Appcolor.appbargroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 30,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: ordersItemsListController
                                    .cartItems[index].status
                                    .extenTextStyle(
                                        fontSize: Appfontsize.regular16,
                                        fontfamily: Appfonts.appFontFamily,
                                        color: Colors.black54,
                                        textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
