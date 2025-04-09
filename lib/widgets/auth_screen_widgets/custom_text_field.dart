import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isEmail;
  final bool isNumber;
  final TextEditingController textController;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.isEmail = false,
      this.isNumber = false,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.teal.withAlpha(50),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: Appfontsize.small14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ${label.toLowerCase()}';
                  } else if (label.toLowerCase() != "full name" &&
                      value.contains(" ")) {
                    return 'Please enter a valid ${label.toLowerCase()}';
                  } else if (isEmail &&
                      !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  } else if (isNumber &&
                      (value.length > 10 ||
                          !RegExp(r'^[6-9]\d{9}$').hasMatch(value))) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
                controller: textController,
                keyboardType: isEmail
                    ? TextInputType.emailAddress
                    : isNumber
                        ? TextInputType.number
                        : TextInputType.text,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: isNumber
                      ? const Text(
                          "  +91 ",
                          style: TextStyle(fontSize: Appfontsize.regular16),
                        )
                      : null,
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 25),
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: Appfontsize.small14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.teal.withAlpha(50),
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
