import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final Function? validator;
  final bool isEmail;
  final bool isMobileNumber;
  final bool isNumberField;
  final bool isOptional;
  final TextEditingController textController;
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.textController,
    this.maxLines,
    this.validator,
    this.isEmail = false,
    this.isMobileNumber = false,
    this.isNumberField = false,
    this.isOptional = false,
  });

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
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isOptional ? label : "$label*",
                style: const TextStyle(
                  fontSize: Appfontsize.small14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (!isOptional && (value == null || value.isEmpty)) {
                    return 'Please enter your ${label.toLowerCase()}';
                  }

                  if (validator != null) {
                    validator!(value);
                  }

                  return null;
                },
                maxLines: maxLines,
                controller: textController,
                keyboardType: isEmail
                    ? TextInputType.emailAddress
                    : isNumberField
                        ? TextInputType.number
                        : TextInputType.text,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: isMobileNumber
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
