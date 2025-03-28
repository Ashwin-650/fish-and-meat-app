import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VendorSignUpScreen extends StatefulWidget {
  const VendorSignUpScreen({super.key});

  @override
  _VendorSignUpScreen createState() => _VendorSignUpScreen();
}

class _VendorSignUpScreen extends State<VendorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _gstController = TextEditingController();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _adhaarController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopLocationController = TextEditingController();

  File? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _gstController.dispose();

    _panController.dispose();
    _adhaarController.dispose();
    _shopNameController.dispose();
    _shopLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appbargroundColor,
        title: 'Signup'
            .extenTextStyle(fontfamily: Appfonts.appFontFamily, fontsize: 24),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name Field
                TextFormField(
                  controller: _gstController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelText: 'GST Number',
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your GST number';
                    }
                    // GST number format validation (15 characters)
                    if (!RegExp(
                            r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid GST number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // PAN Number Field
                TextFormField(
                  controller: _panController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelText: 'PAN Number',
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your PAN number';
                    }
                    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                    if (!panRegex.hasMatch(value)) {
                      return 'Please enter a valid PAN number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Adhaar Number Field
                TextFormField(
                  controller: _adhaarController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    labelText: 'Adhaar Number',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Adhaar number';
                    }
                    if (value.length != 12) {
                      return 'Adhaar number must be 12 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Shop Name Field
                TextFormField(
                  controller: _shopNameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelText: 'Shop Name',
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    prefixIcon: Icon(Icons.storefront),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your shop name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Shop Location Field
                TextFormField(
                  controller: _shopLocationController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelText: 'Shop Location',
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your shop location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(
                    Icons.upload_file,
                    color: Colors.white,
                  ),
                  label: 'Upload Verification Document'
                      .extenTextStyle(color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                if (_selectedFile != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Selected File: ${_selectedFile!.path}'),
                  ),

                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Appcolor.appbargroundColor),
                      minimumSize: const WidgetStatePropertyAll(Size(150, 60)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: 'Submit'.extenTextStyle(
                      color: Colors.white,
                      fontsize: 24,
                      fontfamily: Appfonts.appFontFamily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Convert file to base64 if available
      String idProofBase64 = '';
      if (_selectedFile != null) {
        final bytes = await _selectedFile!.readAsBytes();
        idProofBase64 = base64Encode(bytes);
      }

      final response = await ApiService.postVendorData(
        pan: _panController.text,
        adhaar: _adhaarController.text,
        shopName: _shopNameController.text,
        gstNumber: _gstController.text,
        location: _shopLocationController.text,
        idProof: idProofBase64,
      );

      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vendor registration successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to register vendor: ${response.body ?? 'Unknown error'}')),
        );
      }
    }
  }
}
