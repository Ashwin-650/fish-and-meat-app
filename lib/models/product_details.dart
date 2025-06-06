import 'dart:convert';

class ProductDetails {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double price;
  final String image;
  final List<Reviews> reviews;
  final List<int> availability;
  final String category;
  final int? stock;
  final int? quantity;
  final double? offerPrice;
  final String? productId;

  ProductDetails({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.reviews,
    required this.availability,
    required this.category,
    this.stock,
    this.quantity,
    this.offerPrice,
    this.productId,
  });

  // Factory method to create a ProductDetails from a JSON map
  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      reviews: (json['reviews'] as List?)
              ?.map((reviewJson) => Reviews.fromJson(reviewJson))
              .toList() ??
          [],
      availability: json['availability'] is String
          ? List<int>.from(jsonDecode(json['availability']))
          : List<int>.from(json['availability']),
      category: json['category'],
      quantity: json['quantity'],
      offerPrice: json['offerPrice'],
      stock: json['stock'],
      productId: json['productId'],
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
      'reviews': reviews,
      'availability': availability,
      'category': category,
      'quantity': quantity,
      'offerPrice': offerPrice,
      'stock': stock,
      'productId': productId,
    };
  }
}

class Reviews {
  final String? review;
  final double? rating;
  final String? userid;

  Reviews({
    this.review,
    this.rating,
    this.userid,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      review: json['review'],
      rating: json['rating'] != null ? json['rating'].toDouble() : 0,
      userid: json['userid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating': rating,
      'userid': userid,
    };
  }
}
