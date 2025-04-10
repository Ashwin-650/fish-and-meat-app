import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class CouponSectionWidget extends StatelessWidget {
  const CouponSectionWidget(
      {super.key,
      required this.onTap,
      required this.onChanged,
      required this.textEditingController});
  final Function onTap;
  final Function onChanged;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Appcolor.itemBackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: Colors.teal),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (value) {
                onChanged;
              },
              decoration: const InputDecoration(
                hintText: 'Enter coupon code',
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.bottomBarColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: 'Apply'.extenTextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
