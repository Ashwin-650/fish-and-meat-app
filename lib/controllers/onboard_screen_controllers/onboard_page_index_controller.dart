import 'package:get/get.dart';

class OnboardPageIndexController extends GetxController {
  RxBool onLastPage = RxBool(false);

  toggle() => onLastPage.value = !onLastPage.value;
}
