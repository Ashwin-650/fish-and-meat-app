import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/constants/globals.dart';
import 'package:fish_and_meat_app/controllers/home_page_controllers/home_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/utils/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSelling extends StatelessWidget {
  final int index;

  const TopSelling({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Appcolor.backgroundColor,
        ),
        width: 150,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                            "${Globals.imagePath}\\${HomeController().items[index].image}",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                HomeController().items[index].title.extenTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Appfontsize.medium18,
                    textAlign: TextAlign.center)
              ],
            ),
            Positioned(
              top: 16,
              right: 10,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IconButton(
                  icon: const Icon(size: 30, Icons.add, color: Colors.black),
                  onPressed: () async {
                    final response = await ApiService.addToCart(
                      token: await Globals.loginToken,
                      item: HomeController().items[index],
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
                  constraints: const BoxConstraints(
                    minHeight: 36,
                    minWidth: 36,
                  ),
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
