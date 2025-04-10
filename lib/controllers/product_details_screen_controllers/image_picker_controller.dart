import 'dart:io';

import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  // Rxn allows null values (File? equivalent)
  Rxn<File> pickedImage = Rxn<File>();

  void setImage(File image) {
    pickedImage.value = image;
  }

  void clearImage() {
    pickedImage.value = null;
  }
}
