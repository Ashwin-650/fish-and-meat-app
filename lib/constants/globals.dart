import 'package:fish_and_meat_app/utils/shared_preferences_services.dart';

class Globals {
  static const String baseUrl = "http://192.168.1.137:3000/api";
  static const String apiToken = "login_token";
  static const String imagePath = "http://192.168.1.137:3000\\uploads";

  static Future<String> get loginToken async {
    return await SharedPreferencesServices.getValue(apiToken, "");
  }
}
