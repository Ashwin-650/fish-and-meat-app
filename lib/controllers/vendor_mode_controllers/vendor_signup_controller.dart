import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_approval_screen.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorSignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController gstController = TextEditingController();

  final TextEditingController panController = TextEditingController();
  final TextEditingController adhaarController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopLocationController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    gstController.dispose();

    panController.dispose();
    adhaarController.dispose();
    shopNameController.dispose();
    shopLocationController.dispose();
    super.dispose();
  }

  Future<void> storeSignUpData() async {
    await SharedPreferencesServices.setValue('gst_number', gstController.text);
    await SharedPreferencesServices.setValue('pan_number', panController.text);
    await SharedPreferencesServices.setValue(
        'adhaar_number', adhaarController.text);
    await SharedPreferencesServices.setValue(
        'shop_name', shopNameController.text);
    await SharedPreferencesServices.setValue(
        'shop_location', shopLocationController.text);
  }

  void submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
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
        pan: panController.text,
        aadhaar: adhaarController.text,
        shopname: shopNameController.text,
        gstNumber: gstController.text,
        location: shopLocationController.text,
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
