import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

void showAddressEditBottomSheet(
    {required context, required Function onTapfunction}) {
  TextEditingController addressController = Get.find();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'Edit Delivery Address'.extenTextStyle(
            fontSize: Appfontsize.medium18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Full Address',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onTapfunction();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: 'Save Address'.extenTextStyle(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
