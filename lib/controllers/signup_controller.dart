import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isConditionsAgreed = false.obs;

  setTrue() {
    isConditionsAgreed = true.obs;
  }

  setFalse() {
    isConditionsAgreed = false.obs;
  }
}
