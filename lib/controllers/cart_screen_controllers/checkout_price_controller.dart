import 'package:get/get.dart';

class CheckoutPriceController extends GetxController {
  var totalCheckoutPrice = 0.0.obs;

  addPrice(double price) {
    totalCheckoutPrice.value += price;
  }

  resetPrice() {
    totalCheckoutPrice.value = 0.0;
  }
}
