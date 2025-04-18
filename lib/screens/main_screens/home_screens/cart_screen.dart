import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/controllers/cart_screen_controllers/cart_screen_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/helpers/carts/show_address_bottom_sheet.dart';
import 'package:fish_and_meat_app/helpers/carts/show_location_bottom_sheet.dart';
import 'package:fish_and_meat_app/helpers/carts/show_mobile_edit_bottom_sheet.dart';

import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/razorpay_services.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/address_section_widget.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/cart_item_widget.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/coupon_section_widget.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/order_summary_widget.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/placeorder_button_widget.dart';
import 'package:fish_and_meat_app/widgets/custom_date_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartItemsListController _cartItemsListController = Get.find();
  final TextEditingController _textEditingController =
      (TextEditingController());
  final CartScreenController _cartScreenController =
      Get.put(CartScreenController());

  final RxString _selectedLocation = 'Home'.obs;
  final RxString _selectedAddress =
      '123 Main St, Apt 4B, New York, NY 10001'.obs;
  final RxString _mobileNumber = '+1 (555) 123-4567'.obs;
  final RxBool _couponApplied = false.obs;
  final Rx<DateTime> _deliveryDate =
      DateTime.now().add(const Duration(days: 1)).obs;

  void _showLocationBottomSheet(
    BuildContext context,
  ) {
    showLocationBottomSheet(
        context: context,
        selectedLocation: _selectedLocation,
        ontapFunction: () {
          _selectedLocation.value = 'Home';
          _selectedAddress.value = '123 Main St, Apt 4B, New York, NY 10001';
        },
        selectedLocation2: _selectedLocation,
        ontapFunction2: () {
          _selectedLocation.value = 'Work';
          _selectedAddress.value =
              '456 Office Blvd, Suite 100, New York, NY 10002';
        });
  }

  void _showAddressEditBottomSheet(
    BuildContext context,
  ) {
    TextEditingController addressController =
        Get.put(TextEditingController(text: _selectedAddress.value));
    showAddressEditBottomSheet(
        context: context,
        onTapfunction: () {
          _selectedAddress.value = addressController.text;
        });
  }

  void _showMobileEditBottomSheet(BuildContext context) {
    TextEditingController mobileController =
        Get.put(TextEditingController(text: _mobileNumber.value));
    showMobileEditBottomSheet(
        context: context,
        onTapFunction: () {
          _mobileNumber.value = mobileController.text;
        });
  }

  void _showDatePickerDialog(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deliveryDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null && picked != _deliveryDate.value) {
      _deliveryDate.value = picked;
    }
  }

  void _applyCoupon(BuildContext context, {required String code}) async {
    final response = await ApiService.verifyPromoCode(
        token: await Globals.loginToken, code: code);
    if (response != null && response.statusCode == 200) {
      _couponApplied.value = true;
      Get.snackbar(
        "Success",
        "Coupon applied successfully!",
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      final data = jsonDecode(response.body)["data"];
      final discountPercent = data["discountPercentage"];
      _cartScreenController.changeDiscount(discountPercent);
    } else {
      _couponApplied.value = false;
      final error = jsonDecode(response.body)["message"];
      Get.snackbar(
        "Failed",
        error,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      _cartScreenController.changeDiscount(0);
    }
  }

  void _placeOrder() async {
    ApiService.checkoutCart(
        token: await Globals.loginToken,
        amount: _cartItemsListController.totalCheckoutPrice.value.toString(),
        address: "address",
        pincode: 673003,
        preOrder: "preOrder");
    RazorpayServices.init();
    RazorpayServices.openCheckOut(amount: 100000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appbargroundColor,
        title: 'Cart'.extenTextStyle(
            color: Appcolor.primaryColor.value,
            fontSize: Appfontsize.appBarHeadSize,
            fontfamily: Appfonts.appFontFamily,
            fontWeight: FontWeight.bold),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => _showLocationBottomSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Appcolor.primaryColor.value,
                  ),
                  const SizedBox(width: 4),
                  _selectedLocation.value.extenTextStyle(
                    fontSize: Appfontsize.medium18,
                    fontWeight: FontWeight.w500,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final price = _cartItemsListController.totalCheckoutPrice.value;
        final discount =
            (_cartScreenController.discountPercent.value / 100) * price;
        final finalPrice = price - discount;

        return _cartItemsListController.cartItems.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.network(
                      "https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-illustration-download-in-svg-png-gif-file-formats--shopping-ecommerce-simple-error-state-pack-user-interface-illustrations-6024626.png?f=webp",
                    ),
                  ),
                  'Your cart is empty'.extenTextStyle(
                      color: Appcolor.secondaryColor,
                      fontSize: Appfontsize.high20,
                      fontWeight: FontWeight.bold),
                ],
              ))
            : SlidingUpPanel(
                maxHeight: MediaQuery.sizeOf(context).height - 200,
                minHeight: 190,
                borderRadius: BorderRadius.circular(20),
                body: // Items List
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: "Items".extenTextStyle(
                        fontSize: Appfontsize.medium18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 350),
                        itemCount: _cartItemsListController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item =
                              _cartItemsListController.cartItems[index];
                          return CartItemWidget(
                            item: item,
                            onDelete: () async {
                              //add api for remove from cart
                              final response = await ApiService.deleteCartItem(
                                  token: await Globals.loginToken, id: item.id);
                              if (response != null &&
                                  (response.statusCode == 200 ||
                                      response.statusCode == 201)) {
                                _cartItemsListController.cartItems.removeWhere(
                                    (element) => element.id == item.id);
                                _cartItemsListController.update();
                                _cartItemsListController.getItemFromCart();
                                Get.showSnackbar(const GetSnackBar(
                                  message: 'removed successfull',
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                panel: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Container(
                          width: 120,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            // Coupon Section
                            CouponSectionWidget(
                              onTap: () {
                                _applyCoupon(context,
                                    code: _textEditingController.text);
                              },
                              onChanged: () {
                                _couponApplied.value = false;
                              },
                              textEditingController: _textEditingController,
                            ),

                            const SizedBox(height: 16),

                            // Scheduling Section
                            CustomDateFieldWidget(
                              ontap: () => _showDatePickerDialog(context),
                              initialDate: _deliveryDate.value,
                              text: 'Schedule Your Delivery'.extenTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Appfontsize.regular16,
                              ),
                              icon: Icon(Icons.schedule,
                                  color: Appcolor.primaryColor.value),
                            ),
                            const SizedBox(height: 16),

                            // Address Section
                            AddressSectionWidget(
                              onTap: () => _showAddressEditBottomSheet,
                              selectedAddress: _selectedAddress.value,
                              mobileNumber: _mobileNumber.value,
                              onTapMobile: () => _showMobileEditBottomSheet,
                            ),

                            const SizedBox(height: 16),

                            // Order Summary
                            OrderSummaryWidget(
                              discount: discount,
                              totalAmount: price,
                              couponApplied: _couponApplied.value,
                              totalCheckOut: finalPrice.truncate(),
                              roundOff:
                                  finalPrice - finalPrice.truncateToDouble(),
                            ),
                          ],
                        ),
                      ),
                      // Place Order Button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 75),
                        child: PlaceorderButtonWidget(onTap: _placeOrder),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
