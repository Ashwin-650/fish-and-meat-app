import 'package:http/http.dart' as http;
import 'dart:io';

class VendorSignUpFormData {
  String gstNumber;
  String panNumber;
  String adhaarNumber;
  String shopName;
  String shopLocation;
  File image; // Image as a File

  VendorSignUpFormData({
    required this.gstNumber,
    required this.panNumber,
    required this.adhaarNumber,
    required this.shopName,
    required this.shopLocation,
    required this.image,
  });

  Future<http.MultipartRequest> toMultipartRequest(String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Adding string fields
    request.fields['gstNumber'] = gstNumber;
    request.fields['pan'] = panNumber;
    request.fields['adhaar'] = adhaarNumber;
    request.fields['shopName'] = shopName;
    request.fields['shopLocation'] = shopLocation;

    // Adding the image file as multipart
    var imageStream = http.ByteStream(image.openRead());
    var imageLength = await image.length();
    var multipartFile = http.MultipartFile('image', imageStream, imageLength,
        filename: image.path.split('/').last);

    // Add the image as a file part
    request.files.add(multipartFile);

    return request;
  }

  @override
  String toString() {
    return 'GST: $gstNumber, PAN: $panNumber, Aadhaar: $adhaarNumber, Shop: $shopName, Location: $shopLocation, image: ${image.path}';
  }
}
