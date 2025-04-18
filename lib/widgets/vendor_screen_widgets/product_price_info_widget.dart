import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/product_add_vendor_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/product_add_vendor.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ProductPriceInfoWidget extends StatelessWidget {
  ProductPriceInfoWidget({
    super.key,
    required this.hasOffer,
    required this.offerPrice,
    required this.price,
    required this.onTap,
    this.product,
  });
  final bool hasOffer;
  final String offerPrice;
  final String price;
  final Function onTap;
  final ProductDetails? product;
  final ProductAddVendorController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasOffer) ...[
          offerPrice.extenTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontfamily: Appfonts.appFontFamily,
          ),
          const SizedBox(width: 8),
          price.extenTextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            decoration: TextDecoration.lineThrough,
            fontfamily: Appfonts.appFontFamily,
          ),
        ] else
          price.extenTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontfamily: Appfonts.appFontFamily,
          ),
        const Spacer(),
        IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              controller.seletedProduct.value = product;
              Get.to(
                ProductAddVendor(),
              );
            }),
        IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onTap()),
      ],
    );
  }
}
