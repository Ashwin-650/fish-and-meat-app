import 'dart:convert';

class ProductDetails {
  final String id;
  final String userId;
  final String title;
  final String description;
  final int price;
  final String image;
  final String rating;
  final List<int> availability;
  final String category;

  ProductDetails({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.availability,
    required this.category,
  });

  // Factory method to create a ProductDetails from a JSON map
  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      rating: json['rating'],
      availability: List<int>.from(json['availability']),
      category: json['category'],
    );
  }

  // Method to convert a ProductDetails instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'availability': availability,
      'category': category,
    };
  }
}

class CartProduct {
  final String id;
  final String userId;
  final String title;
  final String description;
  final int price;
  final String image;
  final String rating;
  final int quantity;
  final List<int> availability;
  final String category;

  // Constructor
  CartProduct({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.quantity,
    required this.availability,
    required this.category,
  });

  // Factory method to create an instance from a map (useful for parsing data from JSON)
  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      image: map['image'],
      rating: map['rating'],
      quantity: map['quantity'],
      availability: List<int>.from(json.decode(map['availability'])),
      category: map['category'],
    );
  }

  // Method to convert an instance to a map (useful for sending data to a server or saving locally)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'quantity': quantity,
      'availability': availability,
      'category': category,
    };
  }
}
