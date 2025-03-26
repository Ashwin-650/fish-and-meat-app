import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.61:3000";

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
        Uri.parse('$baseUrl/reg'),
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
        Uri.parse('$baseUrl/log'),
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
        Uri.parse('$baseUrl/verifyotp'),
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
        Uri.parse('$baseUrl/resendotp'),
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
            '$baseUrl/allproducts?searchkey=$query&price=$price&category=$category'),
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
}
