import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayServices {
  static Razorpay? _razorpay;

  static void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.showSnackbar(const GetSnackBar(
      message: "Order placed successfully!",
      backgroundColor: Colors.green,
    ));
    print(response.orderId);
  }

  static void _handlePaymentFailure(PaymentFailureResponse response) {
    Get.showSnackbar(const GetSnackBar(
      message: "Payment failed!",
      backgroundColor: Colors.red,
    ));
  }

  static void _handleExternalWallet(ExternalWalletResponse response) {
    Get.showSnackbar(const GetSnackBar(
      message: "Order placed successfully!",
      backgroundColor: Colors.yellow,
    ));
  }

  static void init() {
    _razorpay ??= Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentFailure);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  static void openCheckOut({required int amount}) {
    _razorpay ??= Razorpay();
    var options = {
      'key': Globals.razorToken,
      'amount': amount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'ajayaj2002nov@gmail.com'}
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  static void dispose() {
    if (_razorpay != null) {
      _razorpay?.clear();
    }
  }
}
