import 'package:get/get.dart';

class SelectedCategoryController extends GetxController {
  RxString selectedCategory = RxString("Chicken");

  setCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }
}
