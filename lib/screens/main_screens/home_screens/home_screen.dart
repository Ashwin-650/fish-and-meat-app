import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/home_page_controllers/home_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/carousel_product.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/category_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/meat_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/special_offer_widget.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/top_selling.dart';
import 'package:fish_and_meat_app/widgets/see_all_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Appcolor.appbargroundColor,
                floating: true,
                snap: true,
                elevation: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Hi, John'.extenTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Appfontsize.appBarHeadSize,
                      fontfamily: Appfonts.appFontFamily,
                      color: Appcolor.primaryColor.value,
                    ),
                    'What would you like today?'.extenTextStyle(
                      fontSize: 14,
                      fontfamily: Appfonts.appFontFamily,
                      color: Colors.grey,
                    ),
                  ],
                ),
                actions: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FluentIcons.alert_12_filled),
                        color: Appcolor.secondaryColor,
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: '2'.extenTextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Special Offers Section
                    const SpecialOfferWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: CarouselProduct(),
                    ),

                    // Top Selling Section
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.trending_up,
                                  color: Appcolor.primaryColor.value),
                              const SizedBox(width: 8),
                              'Top Selling Items'.extenTextStyle(
                                fontSize: Appfontsize.headerFontSize,
                                fontfamily: Appfonts.appFontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SeeAllButton(onPressed: () {}),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 220,
                      child: Obx(() {
                        if (controller.items.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_bag_outlined,
                                    size: 48, color: Colors.grey),
                                const SizedBox(height: 8),
                                'No items found'.extenTextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: TopSelling(
                                index: index,
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    // Fish Categories Section
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.set_meal,
                                  color: Appcolor.primaryColor.value),
                              const SizedBox(width: 8),
                              'Fish Categories'.extenTextStyle(
                                fontSize: Appfontsize.headerFontSize,
                                fontfamily: Appfonts.appFontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SeeAllButton(onPressed: () {}),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      height: 250,
                      child: const CategoryGrid(),
                    ),

                    // Meat Categories Section
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.restaurant_menu,
                                  color: Appcolor.primaryColor.value),
                              const SizedBox(width: 8),
                              'Meat Categories'.extenTextStyle(
                                fontSize: Appfontsize.headerFontSize,
                                fontfamily: Appfonts.appFontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SeeAllButton(onPressed: () {}),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      height: 250,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: const MeatGrid(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
