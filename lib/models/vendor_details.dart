class VendorDetails {
  String gstNumber;
  String panNumber;
  String adhaarNumber;
  String shopName;
  String shopLocation;

  VendorDetails({
    required this.gstNumber,
    required this.panNumber,
    required this.adhaarNumber,
    required this.shopName,
    required this.shopLocation,
  });

  // Convert a JSON map into a VendorSignUpFormData object
  factory VendorDetails.fromJson(Map<String, dynamic> json) {
    return VendorDetails(
      gstNumber: json['gstNumber'],
      panNumber: json['panNumber'],
      adhaarNumber: json['adhaarNumber'],
      shopName: json['shopName'],
      shopLocation: json['shopLocation'],
    );
  }

  // Convert a VendorSignUpFormData object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'adhaarNumber': adhaarNumber,
      'shopName': shopName,
      'shopLocation': shopLocation,
    };
  }
}
