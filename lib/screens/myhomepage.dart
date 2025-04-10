import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/controllers/my_home_page_controllers/home_page_index_controller.dart';
import 'package:fish_and_meat_app/controllers/nav_bar_controller.dart';
import 'package:fish_and_meat_app/controllers/orders_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/visibility_button_controller.dart';
import 'package:fish_and_meat_app/helpers/get_items_from_cart.dart';
import 'package:fish_and_meat_app/models/order_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/cart_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/home_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/orders_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/profile_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/search_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Myhomepage extends StatelessWidget {
  Myhomepage({super.key});
  final CartItemsListController _cartItemsListController =
      Get.put(CartItemsListController());
  final OrdersItemsListController ordersItemsListController =
      Get.put(OrdersItemsListController());
  final NavBarController _navBarController = Get.put(NavBarController());
  final VisibilityButtonController _visibilityButtonController =
      Get.put(VisibilityButtonController());
  final CheckoutPriceController _checkoutPriceController =
      Get.put(CheckoutPriceController());
  final HomePageIndexController _homePageIndexController =
      Get.put(HomePageIndexController());

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: _homePageIndexController.selectedPageIndex.value,
          children: _pages,
        ),
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
                    child: Obx(
                      () => BottomNavigationBar(
                        elevation: 0,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Appcolor.bottomBarColor,
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Colors.black,
                        currentIndex:
                            _homePageIndexController.selectedPageIndex.value,
                        onTap: (value) async {
                          _homePageIndexController.switchIndex(value);
                          // Your existing onTap logic
                          if (value == 2) {
                            getItemFromCart(
                                cartItemsListController:
                                    _cartItemsListController,
                                checkoutPriceController:
                                    _checkoutPriceController);
                          } else if (value == 3) {
                            final response = await ApiService.getOrders(
                                token: await Globals.loginToken);
                            if (response != null &&
                                response.statusCode == 200) {
                              ordersItemsListController.setItems(
                                  (json.decode(response.body)["data"] as List)
                                      .map((productJson) =>
                                          OrderDetails.fromJson(productJson))
                                      .toList());
                            }
                          } else if (value == 4) {
                            final response = await ApiService.getUserInfo(
                                token: await Globals.loginToken);
                            if (response != null &&
                                response.statusCode == 200) {
                              final responseData =
                                  jsonDecode(response.body)["data"];
                              if (responseData["vendor"] == "pending" ||
                                  responseData["vendor"] == "true") {
                                _visibilityButtonController.displayVendor();
                              } else {
                                _visibilityButtonController.displayUser();
                              }
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
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
