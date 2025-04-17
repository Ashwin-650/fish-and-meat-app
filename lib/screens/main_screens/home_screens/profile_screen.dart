import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:fish_and_meat_app/constants/appfonts.dart';
import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/visibility_button_controller.dart';
import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/helpers/scroll_listener.dart';
import 'package:fish_and_meat_app/screens/main_screens/home_screens/auth_screen.dart';
import 'package:fish_and_meat_app/screens/settings_screen.dart';
import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/approval_reach_button.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/vendor_button.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_2.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_3.dart';
import 'package:fish_and_meat_app/widgets/profile_screen_widgets/profile_container_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ScrollController _scrollController = ScrollController();
  final VisibilityButtonController _visibilityButtonController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() => scrollListener(_scrollController));
    });
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=1985&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'John',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  color: Appcolor.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => SettingsScreen());
                        },
                        icon: const Icon(
                          FluentIcons.settings_48_regular,
                          color: Appcolor.secondaryColor,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
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
                            fontSize: Appfontsize.high20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => _visibilityButtonController.isVisible.value
                      ? Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.shade400),
                          child: const ApprovalReachButton(),
                        )
                      : Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.shade400),
                          child: const VendorButton(),
                        ),
                ),
                const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ProfileContainerWidget()),
                const Padding(
                    padding: EdgeInsets.all(10.0), child: ProfileContainer2()),
                const Padding(
                    padding: EdgeInsets.all(10.0), child: ProfileContainer3()),
                TextButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.red.shade800),
                      minimumSize: const WidgetStatePropertyAll(Size(200, 50))),
                  onPressed: () {
                    logOut();
                  },
                  child: 'Log out'.extenTextStyle(
                      color: Colors.white,
                      fontfamily: Appfonts.appFontFamily,
                      fontSize: Appfontsize.high20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> logOut() async {
  await SharedPreferencesServices.deleteKey(
    "login_token",
  );

  Get.offAll(() => AuthScreen());
}
