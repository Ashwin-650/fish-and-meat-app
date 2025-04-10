import 'dart:convert';
import 'dart:io';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/available_locations_controller.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/image_picker_controller.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/selected_category_controller.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/custom_combo_box.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
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

  final SelectedCategoryController _selectedCategoryController =
      Get.put(SelectedCategoryController());
  final AvailableLocationsController _availableLocationsController =
      Get.put(AvailableLocationsController());
  final ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imagePickerController.setImage(File(pickedFile.path));
    }
  }

  void _addPincode() {
    if (_pincodeController.text.isNotEmpty &&
        !_availableLocationsController.availableLocations
            .contains(_pincodeController.text)) {
      _availableLocationsController.availableLocations
          .add(_pincodeController.text);
      _pincodeController.clear();
    }
  }

  void _removeLocation(String location) {
    _availableLocationsController.availableLocations.remove(location);
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
          child: Column(
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
                      final image = _imagePickerController.pickedImage.value;
                      return image != null
                          ? Image.file(image, fit: BoxFit.cover)
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 50, color: Colors.grey),
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
                label: "Title*",
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
                  label: "Price*",
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
                label: "Stock*",
                hint: "",
                textController: _stockController,
                isNumberField: true,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              CustomComboBox(
                label: "Category*",
                selectedCategoryController: _selectedCategoryController,
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

              // Display added pincodes
              Obx(
                () => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _availableLocationsController.availableLocations
                      .map((location) {
                    return Chip(
                      label: Text(location),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () => _removeLocation(location),
                    );
                  }).toList(),
                ),
              ),
              if (_availableLocationsController.availableLocations.isEmpty)
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
                    onPress: _onPressed, buttonText: "Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressed(context) async {
    if (_formKey.currentState!.validate()) {
      if (_imagePickerController.pickedImage.value == null) {
        print(
            "Error: Image file does not exist at path: ${_imagePickerController.pickedImage.value!.path}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      if (_availableLocationsController.availableLocations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one location')),
        );
        return;
      }

      // Fetch API Token
      String? token =
          await SharedPreferencesServices.getValue(Globals.apiToken, '');

      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Authentication error. Please login again.')),
        );
        return;
      }

      try {
        final http.Response response = await ApiService.vendorProductAdd(
          token: token,
          title: _titleController.text,
          description: _descriptionController.text,
          price: _priceController.text,
          availability:
              _availableLocationsController.availableLocations.join(','),
          category: _selectedCategoryController.selectedCategory.value,
          offerPrice: _offerPriceController.text,
          stock: _stockController.text,
          image: _imagePickerController.pickedImage.value!,
        );

        try {
          final decodedResponse = jsonDecode(response.body);

          if (decodedResponse == null ||
              !decodedResponse.containsKey('message')) {
            throw Exception("Invalid API response: Missing 'message' field.");
          }


          if ((response.statusCode == 200 || response.statusCode == 201) &&
              decodedResponse['message'].toString().trim().toLowerCase() ==
                  'product added') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully!')),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              print("Popping back to previous screen");
              Navigator.pop(context, true);
            });
          } else {
            print(
                "API Error: ${decodedResponse['message'] ?? 'Unknown error'}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      decodedResponse['message'] ?? 'Failed to add product')),
            );
          }
        } catch (decodeError) {
          print("JSON Decoding Error: $decodeError");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to parse response from server')),
          );
        }
      } catch (error, stackTrace) {
        print("Exception caught: $error");
        print("Stack trace: $stackTrace");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }

  }
}
