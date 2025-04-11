import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_approval_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/adhaar_number_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/gst_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/pan_number_field_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/signup_screen/field_widget.dart';
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
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gst Field
                GstFieldWidget(
                  gstController: _gstController,
                ),

                // PAN Number Field
                PanNumberFieldWidget(panController: _panController),

                // Adhaar Number Field
                AdhaarNumberFieldWidget(adhaarController: _adhaarController),

                // Shop Name Field
                FieldWidget(
                    controller: _shopNameController,
                    label: 'Shop name',
                    request: 'Please enter your Shop Name'),
                // Shop Location Field
                FieldWidget(
                    controller: _shopLocationController,
                    label: 'Shop Location',
                    request: 'Please enter your Shop Location'),

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token not found')),
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
