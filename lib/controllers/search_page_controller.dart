import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  RxInt pageIndex = RxInt(0);
  switchIndex(int newIndex) => pageIndex.value = newIndex;

  RxList<ProductDetails> queryItems = RxList([]);
  updateList(List<ProductDetails> newList) => queryItems.value = newList;
  clearList() => queryItems.value = RxList([]);

  RxBool hasNextPage = false.obs;
  yesHasNextPage() => hasNextPage = true.obs;
  noHasNextPage() => hasNextPage = false.obs;

  RxString continuationToken = "".obs;
  setContinuationToken(String token) => continuationToken = token.obs;
  resetContinuationToken() => continuationToken = "".obs;
}
