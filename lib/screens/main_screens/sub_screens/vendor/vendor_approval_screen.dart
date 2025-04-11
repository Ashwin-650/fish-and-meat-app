import 'dart:convert';

import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_mode.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorApprovalScreen extends StatefulWidget {
  const VendorApprovalScreen({super.key});

  @override
  State<VendorApprovalScreen> createState() => _VendorApprovalScreenState();
}

class _VendorApprovalScreenState extends State<VendorApprovalScreen> {
  bool _isLoading = true;
  bool _isApproved = false;

  @override
  void initState() {
    super.initState();
    _fetchVendorApprovalStatus();
  }

  Future<void> _fetchVendorApprovalStatus() async {
    print("Fetching vendor approval status...");

    setState(() {
      _isLoading = true;
    });

    try {
      String? token = await Globals.loginToken;

      if (token.isEmpty) {
        Get.snackbar("Error", "Authentication token is missing.");
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }

      final response = await ApiService.getApprovalVendor(token: token);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final responseData = responseBody["data"];

          if (responseData["status"] == "success") {
            if (mounted) {
              setState(() {
                _isApproved = true;
                _isLoading = false;
              });
            }

            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                Get.off(() => VendorMode());
              }
            });
          } else if (responseData["status"] == "pending") {
            if (mounted) {
              setState(() {
                _isApproved = false;
                _isLoading = false;
              });
            }
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
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Approval'),
        centerTitle: true,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _isApproved
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
                      const Icon(Icons.pending, color: Colors.orange, size: 60),
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
    );
  }
}
