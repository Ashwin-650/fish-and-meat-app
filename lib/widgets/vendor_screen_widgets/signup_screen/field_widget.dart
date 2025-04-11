import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.request});
  final TextEditingController controller;
  final String label;
  final String request;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white38,
        filled: true,
        labelText: label,
        labelStyle: const TextStyle(fontFamily: Appfonts.appFontFamily),
        prefixIcon: const Icon(Icons.storefront),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return request;
        }
        return null;
      },
    );
  }
}
