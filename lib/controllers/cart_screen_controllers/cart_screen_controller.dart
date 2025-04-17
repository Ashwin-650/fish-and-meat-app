import 'package:get/get.dart';

class CartScreenController extends GetxController {
  // Now uses String keys instead of int
  var itemCounts = <String, RxInt>{}.obs;

  void increment(String itemId) {
    itemCounts.putIfAbsent(itemId, () => 0.obs);
    itemCounts[itemId]!.value++;
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

//   void removeItem(CartItemModel item) {
//   cartItems.remove(item);
//   update(); // or cartItems.refresh() if it's an RxList
// }
}
