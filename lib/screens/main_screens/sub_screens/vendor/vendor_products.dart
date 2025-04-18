import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/vendor_mode_controllers/vendor_products_items_controller.dart';
import 'package:fish_and_meat_app/helpers/vendor_profile/delete_confirm_helper.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/no_product_added_widget.dart';
import 'package:fish_and_meat_app/widgets/vendor_screen_widgets/product_price_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorProducts extends StatelessWidget {
  VendorProducts({super.key});

  final VendorProductsItemsController controller =
      Get.put(VendorProductsItemsController());

  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

  Widget _buildProductCard(BuildContext context, ProductDetails product) {
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
                    deleteConfirmationHelepr(
                        context: context,
                        productId: product.id,
                        productName: product.title,
                        deleteConfirm: controller.deleteProduct);
                  },
                  product: product,
                )
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
              controller.isLoading.value = true;
              controller.fetchProducts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () async {
              final result = await Get.to(() => ProductAddVendor());
              if (result == true) {
                controller.fetchProducts();
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            RefreshIndicator(
              key: _refreshKey,
              onRefresh: controller.fetchProducts,
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.products.isEmpty
                      ? const Center(child: NoProductAddedWidget())
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                              bottom: 80), // Space for FAB
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) => _buildProductCard(
                              context, controller.products[index]),
                        ),
            ),
            if (controller.isDeleting.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
