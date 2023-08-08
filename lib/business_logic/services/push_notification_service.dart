import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/logicConstants.dart';

////////////////////////////////////////////// RECEIVE MESSAGE ///////////////////////////////////////////////////////////////

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

void initNotification() {
  requestNotificationPermission();
  configureFirebaseMessaging();
  initLocalNotification();
}

const androidChannel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance);

final _localNotifications = FlutterLocalNotificationsPlugin();

Future initLocalNotification() async {
  const android = AndroidInitializationSettings('@drawable/logo_black');
  const settings = InitializationSettings(android: android);
  await _localNotifications.initialize(settings);
  final platform = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(androidChannel);
}

void requestNotificationPermission() async {
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Notification permission granted.');
  } else {
    print('User declined notification permission.');
  }
}

void configureFirebaseMessaging() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id, androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/logo_black')),
        payload: jsonEncode(message.toMap()));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message opened app: ${message.notification?.title}');

    // Handle the notification when the user taps on it and the app is in the foreground.
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

//////////////////////////////////////   SEND MESSAGE /////////////////////////////////////////////////////////////

class FirebaseApi {
  late Dio dio;

  String get fcmServerKey => dotenv.env['FCM_SERVER_KEY'] ?? '';

  FirebaseApi() {
    BaseOptions options = BaseOptions(
      baseUrl: Constant.fcmBaseUrl,
      contentType: "application/json",
    );

    dio = Dio(options);
  }

  Future<dynamic> sendMessage({
    required String title,
    required String body,
    required String userDeviceToken,
  }) async {
    try {
      var response = await dio.post(
        "/fcm/send",
        data: jsonEncode({
          "to": userDeviceToken,
          "notification": {
            "body": body,
            "title": title,
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          },
        }),
        options: Options(
          headers: {
            'Authorization': 'key=$fcmServerKey', // FCM server key authorization
          },
        ),
      );
      print("Response data: ${jsonEncode(response.data)}");
    } catch (error) {
      print("Error: $error");
    }
  }
}