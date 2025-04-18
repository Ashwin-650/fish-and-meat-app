import 'package:get/get.dart';

class CartScreenController extends GetxController {
  // Now uses String keys instead of int

  var itemCounts = <String, RxInt>{}.obs;
  var discountPercent = 0.obs;

  void changeDiscount(int value) {
    discountPercent = value.obs;
  }

  void decrement(String itemId) {
    if (itemCounts.containsKey(itemId) && itemCounts[itemId]!.value > 0) {
      itemCounts[itemId]!.value--;
    }
  }

  int getItemCount(String itemId) {
    return itemCounts[itemId]?.value ?? 0;
  }

  RxInt getItemCountRx(String itemId) {
    itemCounts.putIfAbsent(itemId, () => 0.obs);
    return itemCounts[itemId]!;
  }
}
