import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/moving_carousel.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/recent_searches_list.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/search_field.dart';
import 'package:fish_and_meat_app/widgets/search_screen_widgets/suggestion_list.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
        child: Container(
          color: Appcolor.backgroundColor,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Appcolor.bottomBarColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey[300]!)),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: SearchField()),
                    const SizedBox(height: 50, child: MovingCarousel()),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  "Suggested",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100, child: SuggestionList()),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  "Recent Searches",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RecentSearchesList()
            ],
          ),
        ),
      ),
    );
  }
}
