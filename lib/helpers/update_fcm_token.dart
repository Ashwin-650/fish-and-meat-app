import 'package:fish_and_meat_app/utils/api_services.dart';

Future<bool> updateFCMToken(
    {required String token, required String fcmToken}) async {
  final fcmResponse = await ApiService.fcmTokenToServer(
    token: token,
    fcmToken: fcmToken,
  );

  if (fcmResponse != null && fcmResponse.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
