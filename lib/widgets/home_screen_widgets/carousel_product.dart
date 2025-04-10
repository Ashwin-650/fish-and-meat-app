import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class CarouselProduct extends StatelessWidget {
  CarouselProduct({super.key});

  final RxInt _currentIndex = 0.obs;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, dynamic>> _productImages = [
    {
      'image':
          'https://assets.tendercuts.in/product/S/F/2fb65cc2-d0c6-4a44-ba7e-337eb2bc72ca.jpg',
      'title': 'Fresh Salmon',
    },
    {
      'image':
          'https://5.imimg.com/data5/SELLER/Default/2024/3/396112574/JE/HA/AC/152930445/fresh-frozen-premium-tuna-saku-cut-piece.jpg',
      'title': 'Premium Tuna',
    },
    {
      'image':
          'https://assets.tendercuts.in/product/S/F/2fb65cc2-d0c6-4a44-ba7e-337eb2bc72ca.jpg',
      'title': 'Grass-fed Beef',
    },
    {
      'image':
          'https://avanita.in/wp-content/uploads/2014/10/fullchicken-1.jpg',
      'title': 'Organic Chicken',
    },
    {
      'image':
          'https://media.istockphoto.com/id/520490716/photo/seafood-on-ice.jpg?s=612x612&w=0&k=20&c=snyxGY26viNQ6BWqW-ez4U7tAO65Z_tmAFPMobiZ9Q4=',
      'title': 'Jumbo Shrimp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _productImages.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Image.network(
                          item['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              item['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Appfontsize.medium18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _productImages.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
