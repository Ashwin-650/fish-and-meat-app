import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/orders_list_tile.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
              itemCount: 4,
              itemBuilder: (context, index) {
                return OrdersListTile(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
