import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class MovingCarousel extends StatelessWidget {
  const MovingCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: 5,
      itemBuilder: (ctx, index1, index2) {
        List<String> hints = [
          "Search for apples...",
          "Find fresh fish...",
          "Check out the best meats...",
          "Discover exotic spices...",
          "Shop for dairy products..."
        ];
        return Center(
          child: Text(
            hints[index1],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      options: FlutterCarouselOptions(
        scrollDirection: Axis.vertical,
        height: 50,
        showIndicator: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 2500),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        enableInfiniteScroll: true,
      ),
    );
  }
}
