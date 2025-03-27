import 'dart:convert';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService();

  static Future<dynamic> registerAccount(
      String fullname, String email, String number) async {
    try {
      Map<String, String> body = {
        'username': fullname,
        'email': email,
        'mobile': "+91$number",
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/reg'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  static Future<dynamic> loginAccount(
      {required String email, required String number}) async {
    try {
      Map<String, String> body = {
        'email': email,
        'mobile': "+91$number",
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/log'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  static Future<dynamic> verifyOTP(String email, String otp) async {
    try {
      Map<String, String> body = {
        'email': email,
        'otp': otp,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/verifyotp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  static Future<dynamic> resendOTP(
      {required String email, required String number}) async {
    try {
      Map<String, String> body = {
        'email': email,
        'mobile': "+91$number",
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/resendotp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  static Future<dynamic> getProducts({
    required String token,
    String query = "",
    String price = "",
    String category = "",
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Globals.baseUrl}/allproducts?searchkey=$query&price=$price&category=$category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token $token'
        },
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> fcmTokenToServer({
    required String token,
    required String fcmToken,
  }) async {
    try {
      Map<String, String> body = {
        'fcmToken': fcmToken,
      };

      final response = await http.put(
        Uri.parse('${Globals.baseUrl}/updatefcm'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token $token'
        },
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }
}
