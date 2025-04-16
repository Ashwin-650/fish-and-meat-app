import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulingSectionWidget extends StatelessWidget {
  const SchedulingSectionWidget(
      {super.key, required this.ontap, required this.deliveryDate});
  final GestureTapCallback ontap;
  final DateTime deliveryDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Appcolor.itemBackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: Appcolor.primaryColor),
              const SizedBox(width: 8),
              'Schedule Your Delivery'.extenTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Appfontsize.regular16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(deliveryDate),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Appcolor.primaryColor,
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
