import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/vendor_mode_controllers/promo_code_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/promo_code_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/custom_date_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreatePromoCode extends StatelessWidget {
  CreatePromoCode({super.key});

  final TextEditingController _discountPercentController =
      TextEditingController();
  final TextEditingController _minimumAmountController =
      TextEditingController();
  final PromoCodeController _promoCodeController = Get.find();
  final _promoFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final promo = _promoCodeController.selectedPromo.value;

    if (promo != null) {
      _discountPercentController.text = promo.discountPercentage.toString();
      _minimumAmountController.text = promo.minAmount.toString();
      _promoCodeController.expiryDate.value = promo.expiry;
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _promoCodeController.selectedPromo.value = null;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: (promo != null ? "Edit Promo Code" : "Create Promo Code")
              .extenTextStyle(
            color: Appcolor.primaryColor.value,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Form(
          key: _promoFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              children: [
                CustomTextField(
                  label: "Discount percent",
                  hint: "20",
                  textController: _discountPercentController,
                  isNumberField: true,
                ),
                CustomTextField(
                  label: "Minimum discount amount",
                  hint: "200",
                  textController: _minimumAmountController,
                  isNumberField: true,
                ),
                Obx(
                  () => CustomDateFieldWidget(
                    ontap: () async {
                      _promoCodeController.selectNewDate(context);
                    },
                    initialDate: _promoCodeController.expiryDate.value,
                    text: "Expiry date".extenTextStyle(
                      fontfamily: Appfonts.appFontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CommonButton(
                  onPress: () => createOrUpdatePromoCode(promo),
                  buttonText: promo == null ? "Create" : "Update",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createOrUpdatePromoCode(PromoCodeDetails? promo) async {
    if (_promoFormKey.currentState?.validate() ?? false) {
      final token = await Globals.loginToken;
      final discountPercent = _discountPercentController.text;
      final minimumAmount = _minimumAmountController.text;
      final expiryDate = DateFormat('dd/MM/yyyy')
          .format(_promoCodeController.expiryDate.value!);

      final dynamic response;
      if (promo != null) {
        response = await ApiService.updatePromoCode(
          token: token,
          promoId: promo.id,
          discountPercent: discountPercent,
          minimumAmount: minimumAmount,
          expiryDate: expiryDate,
        );
      } else {
        response = await ApiService.createPromoCode(
          token: token,
          discountPercent: discountPercent,
          minimumAmount: minimumAmount,
          expiryDate: expiryDate,
        );
      }

      if (response == null &&
          response.statusCode == 200 &&
          response.statusCode == 201) {}

      _promoCodeController.selectedPromo.value = null;
      _promoCodeController.getPromoCodes();
      Get.back();
    }
  }
}
