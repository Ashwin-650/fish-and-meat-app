import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class ProfileContainer2 extends StatelessWidget {
  const ProfileContainer2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20)),
      height: 280,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: const Icon(
                Icons.file_copy,
                size: 36,
              ),
              title: 'Terms & Condition'.extenTextStyle(
                  fontfamily: Appfonts.appFontFamily, fontsize: 22),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: const Icon(
                Icons.private_connectivity,
                size: 36,
              ),
              title: 'Privacy Policy'.extenTextStyle(
                  fontfamily: Appfonts.appFontFamily, fontsize: 22),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 36,
              ),
              title: 'Profile Details'.extenTextStyle(
                  fontfamily: Appfonts.appFontFamily, fontsize: 22),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
