import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/list/orders_items_list.dart';
import 'package:flutter/material.dart';

class OrdersListTile extends StatelessWidget {
  final int index;
  OrdersListTile({super.key, required this.index});

  final orders = OrdersItemsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          horizontalTitleGap: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.grey.shade600)),
          tileColor: Colors.white,
          title: orders.orderListname[index].toString().extenTextStyle(
                fontfamily: Appfonts.appFontFamily,
              ),
          subtitle: const Text('Quantity : 3'),
          leading: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage(orders.orderListImage[index].toString())),
                borderRadius: BorderRadius.circular(20)),
          ),
          trailing: Container(
            decoration: BoxDecoration(
                color: Appcolor.appbargroundColor,
                borderRadius: BorderRadius.circular(10)),
            height: 30,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: 'Delivered'.extenTextStyle(
                  fontsize: 16,
                  fontfamily: Appfonts.appFontFamily,
                  color: Colors.black45,
                  textAlign: TextAlign.center),
            ),
          )),
    );
  }
}
