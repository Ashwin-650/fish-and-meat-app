import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:get/get.dart';

class QueryItemsController extends GetxController {
  RxList<ProductDetails> queryItems = RxList([]);

  updateList(List<ProductDetails> newList) => queryItems.value = newList;
  clearList() => queryItems.value = RxList([]);
}
