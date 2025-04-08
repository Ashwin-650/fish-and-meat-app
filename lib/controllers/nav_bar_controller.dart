import 'package:get/get.dart';

class NavBarController extends GetxController {
  var isVisible = true.obs;

  void hide() => isVisible.value = false;
  void show() => isVisible.value = true;
  void toggle() => isVisible.value = !isVisible.value;
}
