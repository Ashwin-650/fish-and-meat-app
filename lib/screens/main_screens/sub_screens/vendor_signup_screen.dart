import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
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
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _adhaarController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopLocationController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _nameController.dispose();

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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    labelText: 'Full Name',
                    labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Phone Number Field

                // Email Field

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

  void _submitForm() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar or process the data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Here you would typically send the data to a backend service
      // For now, we'll just print the values
      print('Name: ${_nameController.text}');

      print('PAN: ${_panController.text}');
      print('Adhaar: ${_adhaarController.text}');
      print('Shop Name: ${_shopNameController.text}');
      print('Shop Location: ${_shopLocationController.text}');
    }
  }
}
