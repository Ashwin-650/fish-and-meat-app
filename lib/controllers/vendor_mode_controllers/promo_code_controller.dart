import 'dart:convert';

import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/models/promo_code_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoCodeController extends GetxController {
  Rxn<PromoCodeDetails> selectedPromo = Rxn<PromoCodeDetails>();
  RxList<PromoCodeDetails> myPromoCodes = RxList([]);
  Rx<DateTime?> expiryDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    getPromoCodes();
  }

  void getPromoCodes() async {
    final token = await Globals.loginToken;
    final response = await ApiService.getPromoCodes(token: token);
    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"];
      myPromoCodes.value = data
          .map<PromoCodeDetails>((json) => PromoCodeDetails.fromJson(json))
          .toList();
    }
  }

  void selectNewDate(BuildContext context) async {
    expiryDate.value = await showDatePicker(
      context: context,
      initialDate: expiryDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
}
