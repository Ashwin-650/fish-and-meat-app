import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

class GstFieldWidget extends StatelessWidget {
  const GstFieldWidget({super.key, required this.gstController});

  final TextEditingController gstController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: gstController,
      decoration: const InputDecoration(
        fillColor: Colors.white38,
        filled: true,
        labelText: 'GST Number',
        labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
        prefixIcon: Icon(Icons.numbers),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your GST number';
        }
        // GST number format validation (15 characters)
        if (!RegExp(
                r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$')
            .hasMatch(value)) {
          return 'Please enter a valid GST number';
        }
        return null;
      },
    );
  }
}
