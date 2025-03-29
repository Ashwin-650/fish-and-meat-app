import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:get/get.dart';

class CartItemsListController extends GetxController {
  // Define the cartItems as RxList
  var cartItems = RxList<CartProduct>([]);

  // Method to set the cart items
  void setItems(List<CartProduct> value) {
    // Directly assign the List<CartProduct> to RxList value
    cartItems.value = value; // No need to cast it to RxList<CartProduct>
  }

  // Method to reset the counter (empty the cart)
  void resetCounter() {
    cartItems.clear(); // Clears the RxList
  }
}
