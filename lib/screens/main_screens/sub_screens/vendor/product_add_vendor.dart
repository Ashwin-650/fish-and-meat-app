import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_form_model.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddVendor extends StatefulWidget {
  @override
  _ProductAddVendorState createState() => _ProductAddVendorState();
}

class _ProductAddVendorState extends State<ProductAddVendor> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _offerPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _categoryController = TextEditingController();
  final _pincodeController = TextEditingController();

  List<String> _availableLocations = [];
  File? _imageFile;
  final List<String> _categories = [
    'Chicken',
    'Beef',
    'Mutton',
    'Pork',
    'Salt Water Fish',
    'Fresh Water Fish',
    'shell Fish',
    'Prawns',
    'Other'
  ];
  String _selectedCategory = 'Chicken';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _offerPriceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addPincode() {
    if (_pincodeController.text.isNotEmpty &&
        !_availableLocations.contains(_pincodeController.text)) {
      setState(() {
        _availableLocations.add(_pincodeController.text);
        _pincodeController.clear();
      });
    }
  }

  void _removeLocation(String location) {
    setState(() {
      _availableLocations.remove(location);
    });
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
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 50, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Tap to select image*',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price*',
                  border: OutlineInputBorder(),
                  prefixText: '₹',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Offer Price Field
              TextFormField(
                controller: _offerPriceController,
                decoration: const InputDecoration(
                  labelText: 'Offer Price (Optional)',
                  border: OutlineInputBorder(),
                  prefixText: '₹',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Stock Field
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock*',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category*',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Locations Section
              const Text(
                'Available Locations (Pincodes)*',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _pincodeController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Pincode',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
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
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _availableLocations.map((location) {
                  return Chip(
                    label: Text(location),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => _removeLocation(location),
                  );
                }).toList(),
              ),
              if (_availableLocations.isEmpty)
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
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_imageFile == null) {
                        print(
                            "Error: Image file does not exist at path: ${_imageFile?.path}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select an image')),
                        );
                        return;
                      }

                      if (_availableLocations.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please add at least one location')),
                        );
                        return;
                      }

                      // Initialize ProductFormModel
                      ProductFormModel productForm = ProductFormModel(
                        title: _titleController.text,
                        //
                        description: _descriptionController.text,
                        //
                        image: _imageFile!,
                        price: double.parse(_priceController.text),
                        //
                        offerPrice: _offerPriceController.text.trim().isEmpty
                            ? null
                            : double.tryParse(
                                _offerPriceController.text.trim()),
                        //
                        stock: int.parse(_stockController.text),
                        availableLocations: _availableLocations.join(','),
                        category: _selectedCategory,
                      );

                      // Fetch API Token
                      String? token = await SharedPreferencesServices.getValue(
                          Globals.apiToken, '');

                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Authentication error. Please login again.')),
                        );
                        return;
                      }

                      try {
                        final http.Response response =
                            await ApiService.vendorProductAdd(
                          token: token,
                          title: productForm.title,
                          description: productForm.description ?? '',
                          price: productForm.price.toString(),
                          availability: productForm.availableLocations,
                          category: productForm.category,
                          offerPrice: productForm.offerPrice?.toString() ?? '0',
                          stock: productForm.stock.toString(),
                          image: _imageFile!,
                        );

                        try {
                          final decodedResponse = jsonDecode(response.body);

                          if (decodedResponse == null ||
                              !decodedResponse.containsKey('message')) {
                            throw Exception(
                                "Invalid API response: Missing 'message' field.");
                          }

                          if ((response.statusCode == 200 ||
                                  response.statusCode == 201) &&
                              decodedResponse['message']
                                      .toString()
                                      .trim()
                                      .toLowerCase() ==
                                  'product added') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Product added successfully!')),
                            );

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              print("Checking mounted status: $mounted");
                              if (mounted) {
                                print("Popping back to previous screen");
                                Navigator.pop(context, true);
                              }
                            });
                          } else {
                            print(
                                "API Error: ${decodedResponse['message'] ?? 'Unknown error'}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(decodedResponse['message'] ??
                                      'Failed to add product')),
                            );
                          }
                        } catch (decodeError) {
                          print("JSON Decoding Error: $decodeError");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Failed to parse response from server')),
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
                  },
                  child: const Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
