import 'package:get/get.dart';

class CartScreenController extends GetxController {
  var discountPercent = 0.obs;

  void changeDiscount(int value) {
    discountPercent = value.obs;
  }
}
