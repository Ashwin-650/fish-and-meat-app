import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

void showLocationBottomSheet(
    {required context,
    required selectedLocation,
    required Function ontapFunction,
    required Function ontapFunction2,
    required selectedLocation2}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'Select Location'.extenTextStyle(
            fontSize: Appfontsize.medium18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.home),
            title: 'Home'.extenTextStyle(),
            subtitle: '123 Main St, Apt 4B'.extenTextStyle(),
            selected: selectedLocation == 'Home',
            onTap: () {
              ontapFunction();

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: 'Work'.extenTextStyle(),
            subtitle: '456 Office Blvd, Suite 100'.extenTextStyle(),
            selected: selectedLocation2 == 'Work',
            onTap: () {
              ontapFunction2();

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: 'Add New Address'.extenTextStyle(),
            onTap: () {
              Navigator.pop(context);
              // Show add address dialog
            },
          ),
        ],
      ),
    ),
  );
}
