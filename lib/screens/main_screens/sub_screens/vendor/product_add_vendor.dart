import 'dart:io';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/product_add_vendor_controller.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/custom_combo_box.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddVendor extends StatelessWidget {
  ProductAddVendor({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _offerPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _pincodeController = TextEditingController();

  final ProductAddVendorController controller =
      Get.put(ProductAddVendorController());

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      controller.setImage(File(pickedFile.path));
    }
  }

  void _addPincode() {
    if (_pincodeController.text.isNotEmpty &&
        !controller.availableLocations.contains(_pincodeController.text)) {
      controller.availableLocations.add(_pincodeController.text);
      _pincodeController.clear();
    }
  }

  void _removeLocation(String location) {
    controller.availableLocations.remove(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Selection
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Obx(() {
                        final image = controller.pickedImage.value;
                        return image != null
                            ? Image.file(image, fit: BoxFit.cover)
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text('Tap to select image*',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                CustomTextField(
                  label: "Title",
                  hint: "",
                  textController: _titleController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Description",
                  hint: "",
                  textController: _descriptionController,
                  maxLines: 3,
                  isOptional: true,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                    label: "Price",
                    hint: "",
                    textController: _priceController,
                    isNumberField: true),
                const SizedBox(height: 16),

                // Offer Price Field
                CustomTextField(
                  label: "Offer Price",
                  hint: "",
                  textController: _offerPriceController,
                  isNumberField: true,
                  isOptional: true,
                ),
                const SizedBox(height: 16),

                // Stock Field
                CustomTextField(
                  label: "Stock",
                  hint: "",
                  textController: _stockController,
                  isNumberField: true,
                ),
                const SizedBox(height: 16),

                // Category Dropdown
                CustomComboBox(
                  label: "Category*",
                  selectedCategoryController: controller,
                ),

                const SizedBox(height: 24),

                // Locations Section
                const Text(
                  'Available Locations (Pincodes)*',
                  style: TextStyle(
                      fontSize: Appfontsize.regular16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Enter Pincode",
                        hint: "",
                        textController: _pincodeController,
                        isNumberField: true,
                        isOptional: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addPincode,
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: controller.availableLocations.map((location) {
                    return Chip(
                      label: Text(location),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () => _removeLocation(location),
                    );
                  }).toList(),
                ),
                if (controller.availableLocations.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Add at least one pincode',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CommonButton(
                      onPress: () {
                        controller.addProduct(
                            context: context,
                            formKey: _formKey,
                            titleController: _titleController,
                            descriptionController: _descriptionController,
                            priceController: _priceController,
                            offerPriceController: _offerPriceController,
                            stockController: _stockController);
                      },
                      buttonText: "Add Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
