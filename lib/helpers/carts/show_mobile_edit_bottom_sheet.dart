import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMobileEditBottomSheet(
    {required context, required Function onTapFunction}) {
  TextEditingController mobileController = Get.find();

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
          'Edit Mobile Number'.extenTextStyle(
            fontSize: Appfontsize.medium18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: mobileController,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                onTapFunction();

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: 'Save Number'.extenTextStyle()),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
