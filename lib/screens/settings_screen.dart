import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/extentions/color_hex.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List<Color> colors = [
    const Color(0xFF8E4585),
    Colors.teal,
    Colors.brown.shade300,
    Colors.indigo.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Settings".extenTextStyle(
          color: Appcolor.primaryColor,
          fontfamily: Appfonts.appFontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              "Accent colors".extenTextStyle(
                fontSize: Appfontsize.headerFontSize,
                fontWeight: FontWeight.bold,
                fontfamily: Appfonts.appFontFamily,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var color in colors)
                    InkWell(
                      onTap: () async {
                        await SharedPreferencesServices.setValue(
                            "AccentColor", color.colorHexString());
                        Appcolor.primaryColor = color;
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
