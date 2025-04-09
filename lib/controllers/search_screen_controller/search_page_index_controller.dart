import 'package:get/get.dart';

class SearchPageIndexController extends GetxController {
  RxInt pageIndex = RxInt(0);

  switchIndex(int newIndex) => pageIndex.value = newIndex;
}
