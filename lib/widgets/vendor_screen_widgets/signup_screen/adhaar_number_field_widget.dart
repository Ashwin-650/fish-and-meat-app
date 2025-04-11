import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdhaarNumberFieldWidget extends StatelessWidget {
  const AdhaarNumberFieldWidget({super.key, required this.adhaarController});
  final TextEditingController adhaarController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: adhaarController,
      decoration: const InputDecoration(
        fillColor: Colors.white38,
        filled: true,
        labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
        labelText: 'Adhaar Number',
        prefixIcon: Icon(Icons.badge),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Adhaar number';
        }
        if (value.length != 12) {
          return 'Adhaar number must be 12 digits';
        }
        return null;
      },
    );
  }
}
