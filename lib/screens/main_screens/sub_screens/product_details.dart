import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String _title;
  late String _description;
  late String _price;
  // late String _offerPrice;
  late String _image;

  int _quantity = 1;
  final double _rating = 1.5;
  // final double _price = 99;

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> arguments = Get.arguments;
    _image = arguments['image'];
    _title = arguments['title'] ?? 'No name';
    _description = arguments['description'] ?? 'No description available';
    _price = arguments['price'] ?? 0;
    // _offerPrice = arguments['offerPrice'];
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  Color _getRatingColor(double rating) {
    if (rating < 2.0) return Colors.red;
    if (rating < 4.0) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 280,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_image),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => Container(
                            color: Colors.grey[300],
                            child:
                                const Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title.extenTextStyle(
                            fontsize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          _description.extenTextStyle(
                            fontsize: 18,
                            color: Colors.grey[700],
                          )
                        ],
                      ),
                    ),
                    "₹$_price".extenTextStyle(
                      fontsize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.bottomBarColor,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Rating: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _getRatingColor(_rating),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: _decrementQuantity,
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Total Price:'.extenTextStyle(
                      fontfamily: Appfonts.appFontFamily,
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      '₹${(double.parse(_price) * _quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.bottomBarColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart!')),
                      );
                    },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        minimumSize:
                            const WidgetStatePropertyAll(Size(300, 60)),
                        backgroundColor:
                            WidgetStatePropertyAll(Appcolor.bottomBarColor)),
                    child: 'Add to Cart'.extenTextStyle(
                        fontfamily: Appfonts.appFontFamily,
                        fontsize: 20,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
