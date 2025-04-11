import 'dart:convert';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/no_product_added_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/product_price_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorMode extends StatefulWidget {
  const VendorMode({super.key});

  @override
  _VendorModeState createState() => _VendorModeState();
}

class _VendorModeState extends State<VendorMode> {
  List<ProductDetails> products = [];
  bool isLoading = true;
  bool isDeleting = false;
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final http.Response response =
          await ApiService.getFromVendor(token: token);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List responseData = responseBody["data"];

        setState(() {
          products = responseData
              .map((json) => ProductDetails.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (error) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _deleteProduct(String productId) async {
    setState(() {
      isDeleting = true;
    });

    String? token =
        await SharedPreferencesServices.getValue(Globals.apiToken, '');

    if (token == null) {
      _showSnackBar('Authentication error. Please login again.', isError: true);
      setState(() => isDeleting = false);
      return;
    }

    try {
      final http.Response response = await ApiService.deleteProduct(
        id: productId,
        token: token,
      );

      if (response.statusCode == 200) {
        setState(() {
          products.removeWhere((product) => product.id == productId);
          isDeleting = false;
        });
        _showSnackBar('Product removed successfully');
      } else {
        final responseData = jsonDecode(response.body);
        String errorMessage =
            responseData['message'] ?? 'Failed to delete product';
        _showSnackBar(errorMessage, isError: true);
        setState(() => isDeleting = false);
      }
    } catch (error) {
      _showSnackBar('Error: ${error.toString()}', isError: true);
      setState(() => isDeleting = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade800 : Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _showDeleteConfirmation(String productId, String productName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "$productName"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteProduct(productId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductDetails product) {
    bool hasOffer = product.offerPrice != null;
    double discount = hasOffer
        ? ((product.price - product.offerPrice!) / product.price) * 100
        : 0.0;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with category tag and discount badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.image.startsWith('http')
                      ? product.image
                      : '${Globals.imagePath}/${product.image}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image,
                        size: 50, color: Colors.grey),
                  ),
                ),
              ),
              // Category tag
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    product.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Discount badge
              if (hasOffer)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${discount.toStringAsFixed(0)}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              // Stock indicator
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: product.stock! > 10 ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Stock: ${product.stock}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: Appfonts.appFontFamily,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                if (product.description.isNotEmpty)
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: Appfonts.appFontFamily,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 12),

                // Price information
                ProductPriceInfoWidget(
                    hasOffer: hasOffer,
                    offerPrice: "₹${product.offerPrice?.toStringAsFixed(2)}",
                    price: "₹${product.price.toStringAsFixed(2)}",
                    onTap: () {
                      _showDeleteConfirmation(
                        product.id,
                        product.title,
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'My Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Appfonts.appFontFamily,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => isLoading = true);
              _fetchProducts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () async {
              final result = await Get.to(() => ProductAddVendor());
              if (result == true) {
                _fetchProducts();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            key: _refreshKey,
            onRefresh: _fetchProducts,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : products.isEmpty
                    ? const Center(child: NoProductAddedWidget())
                    : ListView.builder(
                        padding:
                            const EdgeInsets.only(bottom: 80), // Space for FAB
                        itemCount: products.length,
                        itemBuilder: (context, index) =>
                            _buildProductCard(products[index]),
                      ),
          ),
          if (isDeleting)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
