import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/nav_bar_controller.dart';
import 'package:fish_and_meat_app/controllers/orders_items_list_controller.dart';
import 'package:fish_and_meat_app/models/order_details.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/cart_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/home_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/orders_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/profile_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/search_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final CartItemsListController cartItemsListController =
      Get.put(CartItemsListController());
  final OrdersItemsListController ordersItemsListController =
      Get.put(OrdersItemsListController());
  final NavBarController _navBarController = Get.put(NavBarController());

  int currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    OrdersScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      floatingActionButton: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _navBarController.isVisible.value
              ? Container(
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(100),
                        blurRadius: 10,
                        offset: const Offset(20, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BottomNavigationBar(
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Appcolor.bottomBarColor,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.black,
                      currentIndex: currentIndex,
                      onTap: (value) async {
                        setState(() {
                          currentIndex = value;
                        });

                        // Your existing onTap logic
                        if (value == 2) {
                          final response = await ApiService.getFromCart(
                              token: await Globals.loginToken);
                          if (response != null && response.statusCode == 200) {
                            cartItemsListController.setItems(
                                (json.decode(response.body) as List)
                                    .map((productJson) =>
                                        ProductDetails.fromJson(productJson))
                                    .toList());
                          }
                        } else if (value == 3) {
                          final response = await ApiService.getOrders(
                              token: await Globals.loginToken);
                          if (response != null && response.statusCode == 200) {
                            ordersItemsListController.setItems(
                                (json.decode(response.body)["data"] as List)
                                    .map((productJson) =>
                                        OrderDetails.fromJson(productJson))
                                    .toList());
                          }
                        }
                      },
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.search), label: 'Search'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_cart_outlined),
                            label: 'Cart'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.local_shipping_outlined),
                            label: 'Orders'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), label: 'Profile'),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
