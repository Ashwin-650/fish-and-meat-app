import 'package:get/get.dart';

class AvailableLocationsController extends GetxController {
  RxList<String> availableLocations = RxList([]);

  addLocation(String newLocation) {
    availableLocations.add(newLocation);
  }

  removeLocation(String removeLocation) {
    availableLocations.remove(removeLocation);
  }
}
