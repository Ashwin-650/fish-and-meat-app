import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:flutter/material.dart';

class PanNumberFieldWidget extends StatelessWidget {
  const PanNumberFieldWidget({super.key, required this.panController});

  final TextEditingController panController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: panController,
      decoration: const InputDecoration(
        fillColor: Colors.white38,
        filled: true,
        labelText: 'PAN Number',
        labelStyle: TextStyle(fontFamily: Appfonts.appFontFamily),
        prefixIcon: Icon(Icons.credit_card),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      textCapitalization: TextCapitalization.characters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your PAN number';
        }
        final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
        if (!panRegex.hasMatch(value)) {
          return 'Please enter a valid PAN number';
        }
        return null;
      },
    );
  }
}
