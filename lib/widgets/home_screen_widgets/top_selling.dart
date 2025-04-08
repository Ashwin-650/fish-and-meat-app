import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class TopSelling extends StatelessWidget {
  final String photo;
  final String text;
  final Function()? onAddPressed;

  const TopSelling({
    super.key,
    required this.photo,
    required this.text,
    required this.onAddPressed,
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
        height: 150,
        width: 150,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(photo), fit: BoxFit.cover),
                    ),
                  ),
                ),
                text.extenTextStyle(
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
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
                  onPressed: onAddPressed,
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
