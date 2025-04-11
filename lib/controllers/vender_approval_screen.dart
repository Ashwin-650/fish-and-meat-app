import 'package:get/get.dart';

class VenderApprovalScreen extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isApproved = false.obs;

  setLoadingTrue() {
    isLoading = true.obs;
  }

  setLoadingFalse() {
    isLoading = false.obs;
  }

  setApprovedTrue() {
    isApproved = true.obs;
  }

  setApprovedFalse() {
    isApproved = false.obs;
  }
}
