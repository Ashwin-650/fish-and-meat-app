import 'dart:convert';
import 'dart:io';

class ProductFormModel {
  final String title;
  final String? description; // Nullable
  final File image; // File instead of String
  final double price;
  final double? offerPrice; // Nullable
  final int stock;
  final String category;
  final String availableLocations;

  ProductFormModel({
    required this.title,
    this.description, // Now nullable
    required this.image, // Fixed: Using correct field name
    required this.price,
    this.offerPrice, // Now nullable
    required this.stock,
    required this.category,
    required this.availableLocations,
  });

  /// Convert to FormData for Multipart API submission
  Future<Map<String, String>> toFormData() async {
    return {
      "title": title,
      "description": description ?? "",
      "price": price.toString(),
      "offerPrice": offerPrice?.toString() ?? "",
      "stock": stock.toString(),
      "category": category,
      "availableLocations": jsonEncode(
        availableLocations,
      ) // Convert list to string
    };
  }
}
