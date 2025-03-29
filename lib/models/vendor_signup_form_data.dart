class VendorSignUpFormData {
  String gstNumber;
  String panNumber;
  String adhaarNumber;
  String shopName;
  String shopLocation;

  VendorSignUpFormData({
    required this.gstNumber,
    required this.panNumber,
    required this.adhaarNumber,
    required this.shopName,
    required this.shopLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'adhaarNumber': adhaarNumber,
      'shopName': shopName,
      'shopLocation': shopLocation,
    };
  }

  @override
  String toString() {
    return 'GST: $gstNumber, PAN: $panNumber, Adhaar: $adhaarNumber, Shop: $shopName, Location: $shopLocation';
  }
}
