import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseServices {
  static FirebaseMessaging? firebaseMessaging;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Firebase Messaging
  static Future<void> initializeFirebase() async {
    firebaseMessaging ??= FirebaseMessaging.instance;

    // Request permissions for iOS devices
    await firebaseMessaging?.requestPermission();

    // Configure background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Configure foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      // Handle foreground notification display
      _showNotification(message);
    });

    // Token refresh
    FirebaseMessaging.onTokenRefresh.listen((String token) {
      print('FCM Token refreshed: $token');
      // You may want to save the token to your server here
    });
  }

  // Get the FCM Token
  static Future<String?> getToken() async {
    firebaseMessaging ??= FirebaseMessaging.instance;
    return await firebaseMessaging?.getToken();
  }

  // Handle background message
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Background message received: ${message.notification?.title}');
    // You can perform background work here like updating your app's local database, etc.
  }

  // Show local notifications when a message is received while app is in the foreground
  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'This is a test channel for Firebase messaging',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
    );
  }

  // Handle when the app is opened via a notification
  static Future<void> handleNotificationOpenedApp() async {
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
  static Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging?.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging?.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  // Check for notification permission on iOS (specific to iOS)
  static Future<bool> isNotificationPermissionGranted() async {
    final NotificationSettings settings =
        await firebaseMessaging!.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
