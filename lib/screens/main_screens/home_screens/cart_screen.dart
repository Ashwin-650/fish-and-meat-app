import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/cart_items_list_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/razorpay_services.dart';
import 'package:fish_and_meat_app/widgets/cart_screen_widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartItemsListController _cartItemsListController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();

  String _selectedLocation = 'Home';
  String _selectedAddress = '123 Main St, Apt 4B, New York, NY 10001';
  String _mobileNumber = '+1 (555) 123-4567';
  bool _couponApplied = false;
  final double _discount = 0.0;
  DateTime _deliveryDate = DateTime.now().add(const Duration(days: 1));

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              subtitle: const Text('123 Main St, Apt 4B'),
              selected: _selectedLocation == 'Home',
              onTap: () {
                setState(() {
                  _selectedLocation = 'Home';
                  _selectedAddress = '123 Main St, Apt 4B, New York, NY 10001';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Work'),
              subtitle: const Text('456 Office Blvd, Suite 100'),
              selected: _selectedLocation == 'Work',
              onTap: () {
                setState(() {
                  _selectedLocation = 'Work';
                  _selectedAddress =
                      '456 Office Blvd, Suite 100, New York, NY 10002';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Add New Address'),
              onTap: () {
                Navigator.pop(context);
                // Show add address dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressEditBottomSheet() {
    TextEditingController addressController =
        TextEditingController(text: _selectedAddress);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Delivery Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Full Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedAddress = addressController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save Address'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMobileEditBottomSheet() {
    TextEditingController mobileController =
        TextEditingController(text: _mobileNumber);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Mobile Number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _mobileNumber = mobileController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save Number'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDatePickerDialog() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null && picked != _deliveryDate) {
      setState(() {
        _deliveryDate = picked;
      });
    }
  }

  void _applyCoupon({required String code}) async {
    final response = await ApiService.verifyPromoCode(
        token: await Globals.loginToken, code: code);
    if (response != null && response.statusCode == 200) {
      setState(() {
        _couponApplied = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coupon applied successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid coupon code'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _placeOrder() {
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
            color: Colors.black,
            fontsize: Appfontsize.appBarHeadSize,
            fontfamily: Appfonts.appFontFamily),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: _showLocationBottomSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _selectedLocation,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => _cartItemsListController.cartItems.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : SlidingUpPanel(
                maxHeight: MediaQuery.sizeOf(context).height - 200,
                minHeight: 160,
                borderRadius: BorderRadius.circular(20),
                body: // Items List
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Items",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: _cartItemsListController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = _cartItemsListController.cartItems[index];
                        return CartItemWidget(
                          item: item,
                        );
                      },
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
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Appcolor.itemBackColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.local_offer_outlined,
                                      color: Colors.teal),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _textEditingController,
                                      onChanged: (value) {
                                        setState(() {
                                          _couponApplied = false;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Enter coupon code',
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _applyCoupon(
                                        code: _textEditingController.text),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.bottomBarColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Scheduling Section
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Appcolor.itemBackColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.schedule, color: Colors.teal),
                                      SizedBox(width: 8),
                                      Text(
                                        'Schedule Your Delivery',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Appfontsize.regular16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    onTap: _showDatePickerDialog,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[400]!),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('MMM dd, yyyy')
                                                .format(_deliveryDate),
                                          ),
                                          const Icon(Icons.calendar_today,
                                              size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Address Section
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Appcolor.itemBackColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.teal),
                                          SizedBox(width: 8),
                                          Text(
                                            'Delivery Address',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Appfontsize.regular16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: _showAddressEditBottomSheet,
                                        child: const Text(
                                          'Change',
                                          style: TextStyle(
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _selectedAddress,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Mobile Number
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.phone,
                                              color: Colors.teal),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Mobile Number',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Appfontsize.regular16,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                _mobileNumber,
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: _showMobileEditBottomSheet,
                                          child: const Text(
                                            'Change',
                                            style: TextStyle(
                                              color: Colors.teal,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Order Summary
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Appcolor.itemBackColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.receipt_long,
                                          color: Colors.teal),
                                      SizedBox(width: 8),
                                      Text(
                                        'Order Summary',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Appfontsize.regular16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //...error _text
                                      // const Text('Subtotal'),
                                      // Text('\$${_subtotal.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //......error  _deliveryFee
                                      // const Text('Delivery Fee'),
                                      // _deliveryFee > 0
                                      //     ? Text(
                                      //         '\$${_deliveryFee.toStringAsFixed(2)}')
                                      //     : const Text('FREE',
                                      //         style:
                                      //             TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //.....error   _tax
                                      // const Text('Tax'),
                                      // Text('\$${_tax.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                  if (_couponApplied) ...[
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Discount',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Text(
                                          '-\$${_discount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const Divider(height: 24),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                                      //.....error _total
                                      // Text(
                                      //   '\$${_total.toStringAsFixed(2)}',
                                      //   style: const TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 18,
                                      //     color: Colors.teal,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Place Order Button
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _placeOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
