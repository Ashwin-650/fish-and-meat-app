import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/home_screen_widgets/vendor_button.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_2.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_3.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=1985&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'John',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 20),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          'Edit Profile'.extenTextStyle(
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade200),
                    child: VendorButton(),
                  ),
                  //
                  //
                  const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ProfileContainerWidget()),
                  const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ProfileContainer2()),
                  const Padding(
                      padding: EdgeInsets.all(10.0), child: ProfileContainer3())
                ],
              ),
            ),
          ),
        ));
  }
}
