import 'dart:convert';

import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/vender_approval_screen.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_home.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorApprovalScreen extends StatelessWidget {
  VendorApprovalScreen({super.key});

  final VenderApprovalScreen _venderApprovalScreen =
      Get.put(VenderApprovalScreen());

  Future<void> _fetchVendorApprovalStatus() async {
    _venderApprovalScreen.isLoading = true.obs;

    try {
      String? token = await Globals.loginToken;

      if (token.isEmpty) {
        Get.snackbar("Error", "Authentication token is missing.");
        _venderApprovalScreen.isLoading = false.obs;
        return;
      }

      final response = await ApiService.getApprovalVendor(token: token);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final responseData = responseBody["data"];

          if (responseData["status"] == "success") {
            _venderApprovalScreen.isApproved = true.obs;
            _venderApprovalScreen.isLoading = false.obs;

            Future.delayed(const Duration(seconds: 1), () {
              Get.off(() => VendorHome());
            });
          } else if (responseData["status"] == "pending") {
            _venderApprovalScreen.isApproved = false.obs;
            _venderApprovalScreen.isLoading = false.obs;
          } else {
            Get.snackbar("Error", "Unexpected response from server.");
          }
        } else {
          Get.snackbar("Error", "Server error: ${response.statusCode}");
        }
      } else {
        Get.snackbar("Error", "Invalid response from server.");
      }
    } catch (e) {
      Get.snackbar("Error", "Error connecting to server: ${e.toString()}");
    } finally {
      _venderApprovalScreen.isLoading = false.obs;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _fetchVendorApprovalStatus());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Approval'),
        centerTitle: true,
      ),
      body: Obx(
        () => Center(
          child: _venderApprovalScreen.isLoading.value
              ? const CircularProgressIndicator()
              : _venderApprovalScreen.isApproved.value
                  ? const Text(
                      'Approved! Redirecting...',
                      style: TextStyle(
                        fontSize: Appfontsize.high20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.pending,
                            color: Colors.orange, size: 60),
                        const SizedBox(height: 16),
                        const Text(
                          'Approval Pending',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your application is still under review. Please wait for approval.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Appfontsize.regular16),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _fetchVendorApprovalStatus,
                          child: const Text('Refresh Status'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
