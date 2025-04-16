import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoginWithNumber = true.obs;

  setTrue() {
    isLoginWithNumber = true.obs;
  }

  setFalse() {
    isLoginWithNumber = false.obs;
  }
}
