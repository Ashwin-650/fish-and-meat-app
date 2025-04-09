import 'package:get/get.dart';

class HomePageIndexController extends GetxController {
  RxInt selectedPageIndex = RxInt(0);

  switchIndex(int newIndex) {
    selectedPageIndex.value = newIndex;
  }
}
