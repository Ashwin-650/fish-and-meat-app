import 'package:get/get.dart';

class CartScreenController extends GetxController {
  var singleCartItemCount = 0.obs;

  increment() {
    singleCartItemCount.value += 1;
  }

  decreament() {
    singleCartItemCount.value -= 1;
  }
}
