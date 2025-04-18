import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateFieldWidget extends StatelessWidget {
  const CustomDateFieldWidget({
    super.key,
    required this.ontap,
    required this.initialDate,
    required this.text,
    this.icon,
  });
  final Function() ontap;
  final DateTime? initialDate;
  final Widget text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Appcolor.itemBackColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (icon != null) icon!,
              const SizedBox(width: 8),
              text,
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(initialDate!),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Appcolor.primaryColor.value,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
