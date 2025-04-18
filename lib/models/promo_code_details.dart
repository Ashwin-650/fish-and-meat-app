class PromoCodeDetails {
  final String id;
  final String code;
  final String vendorId;
  final int discountPercentage;
  final int minAmount;
  final DateTime expiry;
  final DateTime createdAt;

  PromoCodeDetails({
    required this.id,
    required this.code,
    required this.vendorId,
    required this.discountPercentage,
    required this.minAmount,
    required this.expiry,
    required this.createdAt,
  });

  factory PromoCodeDetails.fromJson(Map<String, dynamic> json) {
    return PromoCodeDetails(
      id: json['id'],
      code: json['code'],
      vendorId: json['vendorId'],
      discountPercentage: json['discountPercentage'],
      minAmount: json['minAmount'],
      expiry: DateTime.parse(json['expiry']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'vendorId': vendorId,
      'discountPercentage': discountPercentage,
      'minAmount': minAmount,
      'expiry': expiry.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
