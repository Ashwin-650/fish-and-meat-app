import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/product_detailpage_controller/product_detailpage_controller.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/product_detailpage_widgets/quantity_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final ProductDetailpageController controller =
      Get.put(ProductDetailpageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      controller.isFavorite.value ? Colors.red : Colors.white,
                ),
                onPressed: () => controller.toggleFavorite(context),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Sharing product...'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => (controller.productDetails.value ==
                  null) // Null check for productDetails
              ? const Center(child: CircularProgressIndicator())
              // Show a loading indicator while waiting
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hero Image with Gradient Overlay
                            Stack(
                              children: [
                                Hero(
                                  tag: controller.productDetails.value!.image,
                                  child: Container(
                                    height: 350,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${Globals.imagePath}\\${controller.productDetails.value!.image}"),
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                              Icons.image_not_supported,
                                              size: 50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Rating Badge
                                Positioned(
                                  right: 20,
                                  bottom: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: controller.getRatingColor(
                                          controller.rating.value.toDouble()),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          controller.rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Appfontsize.small14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Content Card
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, -3),
                                  ),
                                ],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Price Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller
                                              .productDetails.value!.title,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Appfonts.appFontFamily,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Appcolor.bottomBarColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "₹${controller.productDetails.value!.price}",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.bottomBarColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  // Quantity Selector

                                  QuantitySelectorWidget(
                                    decrementTap: () =>
                                        controller.decrementQuantity(),
                                    incrementTap: () =>
                                        controller.incrementQuantity(),
                                    text: controller.quantity.toString(),
                                  ),

                                  const SizedBox(height: 25),

                                  // Expandable Description Section
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        initiallyExpanded: true,
                                        onExpansionChanged: (expanded) {
                                          controller.isDescriptionExpanded
                                              .value = expanded;
                                        },
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        title: Row(
                                          children: [
                                            const Text(
                                              "Description",
                                              style: TextStyle(
                                                fontSize: Appfontsize.medium18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    Appfonts.appFontFamily,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Appcolor.bottomBarColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                controller.isDescriptionExpanded
                                                        .value
                                                    ? "Collapse"
                                                    : "Read more",
                                                style: TextStyle(
                                                  fontSize: Appfontsize.small14,
                                                  color:
                                                      Appcolor.bottomBarColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(
                                          controller.isDescriptionExpanded.value
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: Appcolor.bottomBarColor,
                                        ),
                                        childrenPadding: EdgeInsets.zero,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 16, 16),
                                            child: Text(
                                              controller.productDetails.value!
                                                  .description,
                                              style: TextStyle(
                                                fontSize: Appfontsize.regular16,
                                                color: Colors.grey[700],
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 25),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Total Price",
                                style: TextStyle(
                                  fontSize: Appfontsize.small14,
                                  color: Colors.grey,
                                  fontFamily: Appfonts.appFontFamily,
                                ),
                              ),
                              Text(
                                "₹${((controller.productDetails.value!.price) * (controller.quantity.value)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.bottomBarColor,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  // final response = await ApiService.addToCart(
                                  //     token: await Globals.loginToken,
                                  //     item: controller.productDetails.value!);
                                  // if (response != null &&
                                  //     (response.statusCode == 200 ||
                                  //         response.statusCode == 201)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Added to cart!'),
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                  // }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolor.bottomBarColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: Appfontsize.regular16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: Appfonts.appFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
