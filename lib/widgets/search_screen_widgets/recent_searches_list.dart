import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentSearchesList extends StatelessWidget {
  RecentSearchesList({super.key});

  final TextEditingController _searchEditingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Appcolor.appbargroundColor,
              border: Border.all(color: Colors.grey[300]!)),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 16.0, right: 10.0),
            leading: Icon(
              Icons.history,
              color: Appcolor.primaryColor.value,
            ),
            title: "Item $index".extenTextStyle(
              fontSize: Appfontsize.medium18,
              fontfamily: Appfonts.appFontFamily,
            ),
            trailing: IconButton(
              onPressed: () {
                _searchEditingController.text = "item $index";
              },
              icon: Transform.flip(
                flipX: true,
                child: Icon(
                  Icons.arrow_outward,
                  color: Appcolor.secondaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
