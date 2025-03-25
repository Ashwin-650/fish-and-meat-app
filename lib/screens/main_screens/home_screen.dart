import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/carousel_product.dart';
import 'package:fish_and_meat_app/widgets/category_grid.dart';
import 'package:fish_and_meat_app/widgets/meat_grid.dart';
import 'package:fish_and_meat_app/widgets/top_selling.dart';
import 'package:fish_and_meat_app/widgets/vendor_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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
        actions: [VendorButton()],
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TopSelling(
                        photo:
                            'https://trulocal.imgix.net/shared/media/blog/152/image.jpg?h=700&fit=max&auto=format,compress',
                        text: 'Beef Boneless');
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
