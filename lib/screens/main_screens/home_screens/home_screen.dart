import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/home_page_controllers/home_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/carousel_product.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/category_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/meat_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/top_selling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ScrollController _scrollController = Get.put(ScrollController());

  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
          child: CustomScrollView(
        controller: _scrollController, // Attach ScrollController here
        slivers: [
          SliverAppBar(
            backgroundColor: Appcolor.appbargroundColor,
            floating: true,
            snap: true,
            title: 'Hii..John '.extenTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Appfontsize.appBarHeadSize,
                fontfamily: Appfonts.appFontFamily),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  child: CarouselProduct(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: 'Top Selling Items'.extenTextStyle(
                      fontSize: Appfontsize.headerFontSize,
                      fontfamily: Appfonts.appFontFamily,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                    height: 180,
                    child: Obx(() {
                      if (controller.items.isEmpty) {
                        return const Center(
                            child: Text("No items found")); // helpful fallback
                      }
                      return SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.items.length,
                          itemBuilder: (context, index) {
                            return TopSelling(
                              index: index,
                            );
                          },
                        ),
                      );
                    })),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Fish Categories'.extenTextStyle(
                            fontSize: Appfontsize.headerFontSize,
                            textAlign: TextAlign.left,
                            fontfamily: Appfonts.appFontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                          TextButton(
                            style: const ButtonStyle(
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black)),
                            onPressed: () {},
                            child: 'See all'.extenTextStyle(
                                fontSize: Appfontsize.small14,
                                fontfamily: Appfonts.appFontFamily),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                      child: CategoryGrid(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Meat Categories'.extenTextStyle(
                            fontSize: Appfontsize.headerFontSize,
                            textAlign: TextAlign.left,
                            fontfamily: Appfonts.appFontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                          TextButton(
                            style: const ButtonStyle(
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black)),
                            onPressed: () {},
                            child: 'See all'.extenTextStyle(
                                fontSize: Appfontsize.small14,
                                fontfamily: Appfonts.appFontFamily),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                      child: MeatGrid(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
