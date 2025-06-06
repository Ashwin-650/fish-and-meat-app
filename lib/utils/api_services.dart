import 'dart:convert';
import 'package:fish_and_meat_app/constants/globals.dart';

import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class ApiService {
  static const header = {
    'Content-Type': 'application/json',
  };
  static Map<String, String> headerWithToken(String token) =>
      {'Content-Type': 'application/json', 'Authorization': 'token $token'};

  static Future<dynamic> registerAccount(
      String fullname, String email, String number) async {
    try {
      Map<String, String> body = {
        'username': fullname,
        'email': email,
        'mobile': "+91$number",
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/auth/register'),
        headers: header,
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
        Uri.parse('${Globals.baseUrl}/auth/login'),
        headers: header,
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  static Future<dynamic> verifyOTP(
      {required String email,
      required String number,
      required String otp}) async {
    try {
      Map<String, String> body = {
        'email': email,
        'mobile': "+91$number",
        'otp': otp,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/auth/verify'),
        headers: header,
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
        Uri.parse('${Globals.baseUrl}/auth/resend'),
        headers: header,
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return null;
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
        Uri.parse('${Globals.baseUrl}/users'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getUserInfo({
    required String token,
  }) async {
    try {
      final response = await http.get(Uri.parse('${Globals.baseUrl}/users'),
          headers: headerWithToken(token));

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getProducts({
    required String token,
    String query = "",
    String price = "",
    String category = "",
    int limit = 15,
    String cursor = "",
  }) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${Globals.baseUrl}/products?search=$query&price=$price&category=$category&limit=$limit&cursor=$cursor'),
          headers: headerWithToken(token));

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> addToCart({
    required String token,
    required ProductDetails item,
  }) async {
    try {
      Map<String, dynamic> body = {
        'productId': item.id,
        'title': item.title,
        'description': item.description,
        'price': item.price,
        'stock': item.stock,
        'image': item.image,
        'reviews': item.reviews,
        'availability': "${item.availability}",
        'category': item.category,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/carts'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> insertToCart({
    required String token,
    required String id,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/carts/$id/increase'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getFromCart({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/carts'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> removeFromCart({
    required String token,
    required String id,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/carts/$id/decrease'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> postVendorData({
    required String token,
    required String pan,
    required String aadhaar,
    required String shopname,
    required String gstNumber,
    required String location,
  }) async {
    try {
      Map<String, dynamic> body = {
        'token': token,
        'pan': pan,
        'aadhaar': aadhaar,
        'shopname': shopname,
        'gstNumber': gstNumber,
        'location': location,
      };

      final response = http.post(
        Uri.parse('${Globals.baseUrl}/vendor/apply'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

//getapplicationstatus
  static Future<dynamic> getApprovalVendor({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/vendor/status'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return (error);
    }
  }

// vendor product add
  static Future<dynamic> vendorProductAdd({
    required String token,
    required String title,
    required String description,
    required String price,
    required String availability,
    required String category,
    required String offerPrice,
    required String stock,
    required File image,
  }) async {
    final url = Uri.parse('${Globals.baseUrl}/products');

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'token $token'
      ..fields['title'] = title
      ..fields['description'] = description
      ..fields['price'] = price
      ..fields['availability'] = availability
      ..fields['category'] = category
      ..fields['offerprice'] = offerPrice
      ..fields['stock'] = stock;

    try {
      final file = await http.MultipartFile.fromPath('image', image.path,
          contentType: MediaType('image', 'jpeg'));
      request.files.add(file);

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);

      return responseData;
    } catch (error) {
      throw Exception('Failed to upload product: $error');
    }
  }

  //vendor product edit
  static Future<dynamic> vendorProductUpdate({
    required String token,
    required String productId, // New for update
    required String title,
    required String description,
    required String price,
    required String availability,
    required String? category,
    required String offerPrice,
    required String stock,
    required File image,
  }) async {
    final url = Uri.parse('${Globals.baseUrl}/products/$productId');

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'token $token'
      ..fields['title'] = title
      ..fields['description'] = description
      ..fields['price'] = price
      ..fields['availability'] = availability
      ..fields['category'] = category!
      ..fields['offerprice'] = offerPrice
      ..fields['stock'] = stock;

    try {
      final file = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(file);

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);

      return responseData;
    } catch (error) {
      throw Exception('Failed to update product: $error');
    }
  }

//vendor product edit no image
  static Future<dynamic> vendorProductUpdateWithoutImage({
    required String token,
    required String productId,
    required String title,
    required String description,
    required String price,
    required String availability,
    required String? category,
    required String offerPrice,
    required String stock,
  }) async {
    final url = Uri.parse('${Globals.baseUrl}/products/$productId');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'price': price,
          'availability': availability,
          'category': category,
          'offerprice': offerPrice,
          'stock': stock,
        }),
      );

      return response;
    } catch (error) {
      throw Exception('Failed to update product: $error');
    }
  }

  static Future<dynamic> getFromVendor({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/products/user'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getItemsCategory({
    required String token,
    required String category,
    int limit = 15,
    String cursor = "",
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Globals.baseUrl}/products?category=$category&limit=$limit&cursor=$cursor'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getProduct(
      {required String token, required String id}) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/products/$id'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> deleteProduct(
      {required String token, required String id}) async {
    try {
      final response = await http.delete(
        Uri.parse('${Globals.baseUrl}/products/$id'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> deleteCartItem(
      {required String token, required String id}) async {
    try {
      final response = await http.delete(
        Uri.parse('${Globals.baseUrl}/carts/$id'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> createPromoCode(
      {required String token,
      required String discountPercent,
      required String minimumAmount,
      required String expiryDate}) async {
    try {
      Map<String, dynamic> body = {
        'discount': discountPercent,
        'minAmount': minimumAmount,
        'expiry': expiryDate,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/promocodes'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> updatePromoCode(
      {required String token,
      required String promoId,
      required String discountPercent,
      required String minimumAmount,
      required String expiryDate}) async {
    try {
      Map<String, dynamic> body = {
        'discount': discountPercent,
        'minAmount': minimumAmount,
        'expiry': expiryDate,
      };

      final response = await http.put(
        Uri.parse('${Globals.baseUrl}/promocodes/$promoId'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> deletePromoCode({
    required String token,
    required String promoId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('${Globals.baseUrl}/promocodes/$promoId'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> verifyPromoCode({
    required String token,
    required String code,
  }) async {
    try {
      Map<String, dynamic> body = {
        'code': code,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/promocodes/verify'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getPromoCodes({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/promocodes'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> getOrders({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${Globals.baseUrl}/orders'),
        headers: headerWithToken(token),
      );

      return response;
    } catch (error) {
      return error;
    }
  }

  static Future<dynamic> checkoutCart({
    required String token,
    required String amount,
    required String address,
    required int pincode,
    required String preOrder,
  }) async {
    try {
      Map<String, dynamic> body = {
        'discountAmount': amount,
        'address': address,
        'pincode': pincode,
        'preOrder': preOrder,
      };

      final response = await http.post(
        Uri.parse('${Globals.baseUrl}/checkout'),
        headers: headerWithToken(token),
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      return error;
    }
  }
}
