import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class AddressSectionWidget extends StatelessWidget {
  const AddressSectionWidget(
      {super.key,
      required this.onTap,
      required this.selectedAddress,
      required this.mobileNumber,
      required this.onTapMobile});
  final VoidCallback onTap;
  final VoidCallback onTapMobile;
  final String selectedAddress;
  final String mobileNumber;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Appcolor.primaryColor),
                  const SizedBox(width: 8),
                  'Delivery Address'.extenTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Appfontsize.regular16,
                  ),
                ],
              ),
              TextButton(
                onPressed: onTap
                // _showAddressEditBottomSheet
                ,
                child: 'Change'.extenTextStyle(
                  color: Appcolor.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          selectedAddress.extenTextStyle(
            color: Colors.grey[700],
          ),

          const SizedBox(height: 12),
          // Mobile Number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.phone, color: Appcolor.primaryColor),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Mobile Number'.extenTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Appfontsize.regular16,
                      ),
                      const SizedBox(height: 4),
                      mobileNumber.extenTextStyle(
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: onTapMobile,
                child: 'Change'.extenTextStyle(
                  color: Appcolor.primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
