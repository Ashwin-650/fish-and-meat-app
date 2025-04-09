import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/nav_bar_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/helpers/scroll_listener.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/carousel_product.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/category_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/meat_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/top_selling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductDetails> items = [];
  final NavBarController _navBarController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
    _scrollController.addListener(() => scrollListener(_scrollController));
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  init() async {
    final response =
        await ApiService.getProducts(token: await Globals.loginToken);
    if (response != null && response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final responseData = responseBody["data"];

      final List<dynamic> productList = responseData;

      setState(() {
        items = productList
            .map((productJson) => ProductDetails.fromJson(productJson))
            .toList();
      });
    }
  }

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
                fontsize: Appfontsize.appBarHeadSize,
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  child: CarouselProduct(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: 'Top Selling Items'.extenTextStyle(
                      fontsize: Appfontsize.headerFontSize,
                      fontfamily: Appfonts.appFontFamily,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return TopSelling(
                        photo: "${Globals.imagePath}\\${items[index].image}",
                        text: items[index].title,
                        onAddPressed: () async {
                          final response = await ApiService.addToCart(
                            token: await Globals.loginToken,
                            item: items[index],
                          );
                          if (response != null &&
                              (response.statusCode == 200 ||
                                  response.statusCode == 201)) {
                            Get.showSnackbar(
                              const GetSnackBar(
                                message: "Added to cart",
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
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
                              fontsize: Appfontsize.headerFontSize,
                              textAlign: TextAlign.left,
                              fontfamily: Appfonts.appFontFamily),
                          TextButton(
                            style: const ButtonStyle(
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black)),
                            onPressed: () {},
                            child: 'See all'.extenTextStyle(
                                fontsize: Appfontsize.small14,
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
                              fontsize: Appfontsize.headerFontSize,
                              textAlign: TextAlign.left,
                              fontfamily: Appfonts.appFontFamily),
                          TextButton(
                            style: const ButtonStyle(
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black)),
                            onPressed: () {},
                            child: 'See all'.extenTextStyle(
                                fontsize: Appfontsize.small14,
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
