import 'package:get/get.dart';

class VisibilityButtonController extends GetxController {
  var isVisible = true.obs;

  void displayUser() => isVisible.value = false;
  void displayVendor() => isVisible.value = true;
  void toggle() => isVisible.value = !isVisible.value;
}
