import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class ProductPriceInfo extends StatelessWidget {
  const ProductPriceInfo(
      {super.key,
      required this.hasOffer,
      required this.offerPrice,
      required this.price,
      required this.onTap});
  final bool hasOffer;
  final String offerPrice;
  final String price;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasOffer) ...[
          offerPrice.extenTextStyle
              // "₹${product.offerPrice!.toStringAsFixed(2)}",
              (
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontfamily: Appfonts.appFontFamily,
          ),
          const SizedBox(width: 8),
          price.extenTextStyle
              // "₹${product.price.toStringAsFixed(2)}",
              (
            fontSize: 14,
            color: Colors.grey.shade700,
            decoration: TextDecoration.lineThrough,
            fontfamily: Appfonts.appFontFamily,
          ),
        ] else
          price.extenTextStyle
              // "₹${product.price.toStringAsFixed(2)}",
              (
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontfamily: Appfonts.appFontFamily,
          ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onTap
            // _showDeleteConfirmation(
            //   product.id,
            //   product.title,
            // ),
            ),
      ],
    );
  }
}
