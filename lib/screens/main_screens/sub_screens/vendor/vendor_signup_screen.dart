import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_approval_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VendorSignUpScreen extends StatefulWidget {
  const VendorSignUpScreen({super.key});

  @override
  State<VendorSignUpScreen> createState() => _VendorSignUpScreen();
}

class _VendorSignUpScreen extends State<VendorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _gstController = TextEditingController();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _adhaarController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopLocationController = TextEditingController();

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
            .extenTextStyle(fontfamily: Appfonts.appFontFamily, fontSize: 24),
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

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.green.shade400),
                      minimumSize: const WidgetStatePropertyAll(Size(150, 60)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: 'Submit'.extenTextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontfamily: Appfonts.appFontFamily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> storeSignUpData() async {
    await SharedPreferencesServices.setValue('gst_number', _gstController.text);
    await SharedPreferencesServices.setValue('pan_number', _panController.text);
    await SharedPreferencesServices.setValue(
        'adhaar_number', _adhaarController.text);
    await SharedPreferencesServices.setValue(
        'shop_name', _shopNameController.text);
    await SharedPreferencesServices.setValue(
        'shop_location', _shopLocationController.text);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      String? token =
          await SharedPreferencesServices.getValue(Globals.apiToken, '');

      if (token == null || token.isEmpty) {
        Get.showSnackbar(
          const GetSnackBar(message: 'Authentication token not found'),
        );
        return;
      }

      final response = await ApiService.postVendorData(
        token: token,
        pan: _panController.text,
        aadhaar: _adhaarController.text,
        shopname: _shopNameController.text,
        gstNumber: _gstController.text,
        location: _shopLocationController.text,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        // Call the method to store data in SharedPreferences
        await storeSignUpData();
        Get.off(() => VendorApprovalScreen());
        Get.showSnackbar(
          const GetSnackBar(message: 'Vendor registration successful'),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
              message:
                  'Failed to register vendor: ${response.body ?? 'Unknown error'}'),
        );
      }
    }
  }
}
