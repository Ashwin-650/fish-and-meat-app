import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServices {
  FirebaseMessaging? firebaseMessaging;
  //final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize Firebase Messaging
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firebaseMessaging ??= FirebaseMessaging.instance;

    // Request permissions for iOS devices
    await firebaseMessaging?.requestPermission();

    // Token refresh
    firebaseMessaging?.onTokenRefresh.listen((String token) {
      print('FCM Token refreshed: $token');
      // You may want to save the token to your server here
    });
  }

  // Get the FCM Token
  Future<String?> getToken() async {
    firebaseMessaging ??= FirebaseMessaging.instance;
    return await firebaseMessaging?.getToken();
  }

  // Show local notifications when a message is received while app is in the foreground
  // Future<void> _showNotification(RemoteMessage message) async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //     'channel_id',
  //     'channel_name',
  //     channelDescription: 'This is a test channel for Firebase messaging',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails platformDetails = NotificationDetails(
  //     android: androidDetails,
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title,
  //     message.notification?.body,
  //     platformDetails,
  //   );
  // }

  // Handle when the app is opened via a notification
  Future<void> handleNotificationOpenedApp() async {
    firebaseMessaging?.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened via notification: ${message.notification?.title}');
        // You can handle navigation based on the notification here
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from notification: ${message.notification?.title}');
      // Handle app navigation based on the notification
    });
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging?.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging?.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  // Check for notification permission on iOS (specific to iOS)
  Future<bool> isNotificationPermissionGranted() async {
    final NotificationSettings settings =
        await firebaseMessaging!.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
