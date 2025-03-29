import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class ProfileContainer3 extends StatelessWidget {
  const ProfileContainer3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 280,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: const Icon(
                  Icons.info,
                  size: 36,
                ),
                title: 'About Us'.extenTextStyle(
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
                  Icons.chat,
                  size: 36,
                ),
                title: 'FAQs'.extenTextStyle(
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
                  Icons.people_outline_outlined,
                  size: 36,
                ),
                title: 'Contact Us'.extenTextStyle(
                    fontfamily: Appfonts.appFontFamily, fontsize: 22),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ));
  }
}
