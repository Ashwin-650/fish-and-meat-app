import 'package:get/get.dart';

class NavBarController extends GetxController {
  RxBool isVisible = RxBool(true);

  void hide() => isVisible.value = false;
  void show() => isVisible.value = true;
  void toggle() => isVisible.value = !isVisible.value;
}
