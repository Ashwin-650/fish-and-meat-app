import 'dart:convert';

import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/models/product_details.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/carousel_product.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/category_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/meat_grid.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/top_selling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductDetails> items = [];
  @override
  void initState() {
    super.initState();
    tests();
  }

  tests() async {
    final response =
        await ApiService.getProducts(token: await Globals.loginToken);
    if (response != null && response.statusCode == 200) {
      setState(() {
        items = (json.decode(response.body) as List)
            .map((productJson) => ProductDetails.fromJson(productJson))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appbargroundColor,
        centerTitle: true,
        title: 'Home '.extenTextStyle(
            fontWeight: FontWeight.w700,
            fontsize: 24,
            fontfamily: Appfonts.appFontFamily),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    fontsize: 26,
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
                          print(response);
                        }
                        Get.showSnackbar(
                          const GetSnackBar(
                            message: "Added to cart",
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                          ),
                        );
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
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Fish Categories'.extenTextStyle(
                            fontsize: 26,
                            textAlign: TextAlign.left,
                            fontfamily: Appfonts.appFontFamily),
                        TextButton(
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.black)),
                          onPressed: () {},
                          child: 'See all'.extenTextStyle(
                              fontsize: 14, fontfamily: Appfonts.appFontFamily),
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
                            fontsize: 26,
                            textAlign: TextAlign.left,
                            fontfamily: Appfonts.appFontFamily),
                        TextButton(
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.black)),
                          onPressed: () {},
                          child: 'See all'.extenTextStyle(
                              fontsize: 14, fontfamily: Appfonts.appFontFamily),
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
        ),
      ),
    );
  }
}
