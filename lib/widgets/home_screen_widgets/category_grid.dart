import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/list/category_items.dart';
import 'package:fish_and_meat_app/screens/main_screens/sub_screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 16 / 9),
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(() => const ItemsScreen(),
                arguments: {'category': 0, 'index': index}),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white70),
                  image: DecorationImage(
                      image:
                          NetworkImage(CategoryItems().categoryImages[index]),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Center(
                  child: CategoryItems()
                      .categoryText[index]
                      .toString()
                      .extenTextStyle(
                          color: Colors.white,
                          fontsize: 20,
                          fontfamily: Appfonts.appFontFamily),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
