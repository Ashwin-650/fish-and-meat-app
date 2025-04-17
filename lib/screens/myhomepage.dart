import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/checkout_price_controller.dart';
import 'package:fish_and_meat_app/controllers/my_home_page_controllers/home_page_index_controller.dart';
import 'package:fish_and_meat_app/controllers/nav_bar_controller.dart';
import 'package:fish_and_meat_app/controllers/orderscreen_controllers/orders_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/visibility_button_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/helpers/get_items_from_cart.dart';
import 'package:fish_and_meat_app/models/order_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/cart_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/home_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/orders_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/profile_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/search_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
      body: Obx(() => Stack(
            children: [
              IndexedStack(
                index: _homePageIndexController.selectedPageIndex.value,
                children: _pages,
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: AnimatedSlide(
                  offset: _navBarController.isVisible.value
                      ? const Offset(0, 0)
                      : const Offset(0, 2),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 12,
                            offset: Offset(0, 6)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BottomNavigationBar(
                        backgroundColor: Appcolor.bottomBarColor,
                        selectedItemColor: Appcolor.secondaryColor,
                        unselectedItemColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        currentIndex:
                            _homePageIndexController.selectedPageIndex.value,
                        onTap: (value) async {
                          _homePageIndexController.switchIndex(value);
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
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(_homePageIndexController
                                          .selectedPageIndex.value ==
                                      0
                                  ? FluentIcons.home_24_filled
                                  : FluentIcons.home_24_regular),
                              label: 'Home'),
                          BottomNavigationBarItem(
                              icon: Icon(_homePageIndexController
                                          .selectedPageIndex.value ==
                                      1
                                  ? FluentIcons.search_24_filled
                                  : FluentIcons.search_24_regular),
                              label: 'Search'),
                          BottomNavigationBarItem(
                            icon: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  _homePageIndexController
                                              .selectedPageIndex.value ==
                                          2
                                      ? FluentIcons.cart_24_filled
                                      : FluentIcons.cart_24_regular,
                                ),
                                _cartItemsListController.cartItems.isNotEmpty
                                    ? Positioned(
                                        top: -4,
                                        right: -6,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFA8072),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child:
                                                "${_cartItemsListController.cartItems.length}"
                                                    .extenTextStyle(
                                              fontSize: Appfontsize.xsmall12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            label: 'Cart',
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(_homePageIndexController
                                          .selectedPageIndex.value ==
                                      3
                                  ? FluentIcons.vehicle_truck_profile_24_filled
                                  : FluentIcons
                                      .vehicle_truck_profile_24_regular),
                              label: 'Orders'),
                          BottomNavigationBarItem(
                              icon: Icon(_homePageIndexController
                                          .selectedPageIndex.value ==
                                      4
                                  ? FluentIcons.person_24_filled
                                  : FluentIcons.person_24_regular),
                              label: 'Profile'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
