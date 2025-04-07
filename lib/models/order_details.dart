import 'package:fish_and_meat_app/models/product_details.dart';

class OrderDetails {
  final String id;
  final String userId;
  final int amount;
  final int discountAmount;
  final String status;
  final DateTime date;
  final List<ProductDetails> items;
  final String address;
  final String pincode;
  final String razorpayOrderId;
  final String? paymentId; // PaymentId can be null
  final DateTime? preOrder; // PreOrder can be null

  OrderDetails({
    required this.id,
    required this.userId,
    required this.amount,
    required this.discountAmount,
    required this.status,
    required this.date,
    required this.items,
    required this.address,
    required this.pincode,
    required this.razorpayOrderId,
    this.paymentId,
    this.preOrder,
  });

  // Factory method to create an Order instance from a JSON map
  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'],
      discountAmount: json['discountAmount'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      items: (json['items'] as List)
          .map((itemJson) => ProductDetails.fromJson(itemJson))
          .toList(),
      address: json['address'],
      pincode: json['pincode'],
      razorpayOrderId: json['razorpayOrderId'],
      paymentId: json['paymentId'], // This can be null
      preOrder:
          json['preOrder'] != null ? DateTime.parse(json['preOrder']) : null,
    );
  }

  // Method to convert an Order instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'discountAmount': discountAmount,
      'status': status,
      'date': date.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'address': address,
      'pincode': pincode,
      'razorpayOrderId': razorpayOrderId,
      'paymentId': paymentId,
      'preOrder': preOrder?.toIso8601String(),
    };
  }
}
