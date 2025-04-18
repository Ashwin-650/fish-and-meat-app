import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/vendor_mode_controllers/promo_code_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/vendor/create_promo_code.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorPromoCodes extends StatelessWidget {
  VendorPromoCodes({super.key});

  final PromoCodeController _promoCodeController =
      Get.put(PromoCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Promo codes".extenTextStyle(
          color: Appcolor.primaryColor.value,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreatePromoCode());
            },
            icon: const Icon(Icons.add_circle_outline),
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _promoCodeController.myPromoCodes.length,
          itemBuilder: (context, index) {
            final promo = _promoCodeController.myPromoCodes[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Appcolor.itemBackColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            promo.code,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _promoCodeController.selectedPromo.value = promo;
                            Get.to(() => CreatePromoCode());
                          },
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            final token = await Globals.loginToken;
                            final response = await ApiService.deletePromoCode(
                                token: token, promoId: promo.id);
                            if (response != null &&
                                response.statusCode == 200) {
                              _promoCodeController.getPromoCodes();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Discount: ${promo.discountPercentage}%',
                        style: const TextStyle(fontSize: 14)),
                    Text('Min Amount: ₹${promo.minAmount}',
                        style: const TextStyle(fontSize: 14)),
                    Text(
                      'Expires on: ${DateFormat('dd/MM/yyyy').format(promo.expiry)}',
                      style: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
                    ),
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
