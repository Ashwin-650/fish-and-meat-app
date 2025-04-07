import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/order_details.dart';
import 'package:flutter/material.dart';

class OrdersListTile extends StatelessWidget {
  final OrderDetails order;
  const OrdersListTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            order.id.extenTextStyle(fontsize: 18, fontWeight: FontWeight.w700),
            ListTile(
              horizontalTitleGap: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title:
                  "Items: ${order.items.length}\nPaid: \$${order.amount}\nDelivered to: ${order.address}"
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
                  child: order.status.extenTextStyle(
                      fontsize: 16,
                      fontfamily: Appfonts.appFontFamily,
                      color: Colors.black45,
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
