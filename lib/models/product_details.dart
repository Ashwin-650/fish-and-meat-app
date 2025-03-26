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
