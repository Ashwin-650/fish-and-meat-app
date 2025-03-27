import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';

class Globals {
  static const String baseUrl = "http://192.168.1.61:3000";
  static const String apiToken = "login_token";
  static const String imagePath = "$baseUrl\\uploads";

  static Future<String> get loginToken async {
    return await SharedPreferencesServices.getValue(apiToken, "");
  }
}
