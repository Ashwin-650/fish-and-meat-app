import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_products.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/vendor_promo_codes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorHome extends StatelessWidget {
  VendorHome({super.key});

  final List<Map<String, dynamic>> gridItems = [
    {'title': 'My Products', 'icon': Icons.shopping_bag},
    {'title': 'Promo Codes', 'icon': Icons.card_giftcard},
    {'title': 'Notifications', 'icon': Icons.notifications},
    {'title': 'Dashboard', 'icon': Icons.dashboard},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: "Vendor".extenTextStyle(
        color: Appcolor.primaryColor.value,
        fontWeight: FontWeight.bold,
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: gridItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 per row
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // square cards
          ),
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  switch (item['title']) {
                    case 'My Products':
                      Get.to(() => VendorProducts());
                    case 'Promo Codes':
                      Get.to(() => const VendorPromoCodes());
                      break;
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'],
                        size: 40, color: Appcolor.secondaryColor),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
