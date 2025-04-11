import 'package:get/get.dart';

class AvailableLocationsController extends GetxController {
  // Use RxList to make it reactive
  RxList<String> availableLocations = <String>[].obs;

  // Method to add a pincode to the list
  void addPincode(String pincode) {
    if (pincode.isNotEmpty && !availableLocations.contains(pincode)) {
      availableLocations.add(pincode);
    }
  }
}
