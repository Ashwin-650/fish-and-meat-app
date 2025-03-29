import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class ProfileContainerWidget extends StatelessWidget {
  const ProfileContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: const Icon(
                  Icons.favorite_border_outlined,
                  size: 36,
                ),
                title: 'WishList'.extenTextStyle(
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
                  Icons.monetization_on,
                  size: 36,
                ),
                title: 'Refer & Earn'.extenTextStyle(
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
                  Icons.payment,
                  size: 36,
                ),
                title: 'Saved Payment Options'.extenTextStyle(
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
                  Icons.location_on_rounded,
                  size: 36,
                ),
                title: 'My Addresses'.extenTextStyle(
                    fontfamily: Appfonts.appFontFamily, fontsize: 22),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
