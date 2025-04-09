import 'package:get/get.dart';

class CheckoutPriceController extends GetxController {
  RxInt totalCheckoutPrice = RxInt(0);

  addPrice(int price) {
    totalCheckoutPrice.value += price;
  }

  resetPrice() {
    totalCheckoutPrice.value = 0;
  }
}
