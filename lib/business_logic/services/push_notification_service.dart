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

  String get fcmKey => dotenv.env['FCM_KEY'] ?? '';
  String get refreshToken => dotenv.env['REFRESH_TOKEN'] ?? ''; // Retrieve the refresh token

  FirebaseApi() {
    BaseOptions options = BaseOptions(
      baseUrl: Constant.fcmBaseUrl,
      contentType: "application/json",
    );

    dio = Dio(options);

    // Interceptor to check and refresh token
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check if the token is expired or about to expire (e.g., within 5 minutes)
        if (isTokenExpired()) {
          // Refresh the token
          await refreshTokenIfNeeded();
        }

        // Add the refreshed token to the request headers
        options.headers['Authorization'] = 'Bearer $fcmKey';

        return handler.next(options);
      },
    ));
  }

  bool isTokenExpired() {
    // Implement your logic to check if the token is expired
    // Return true if the token is expired or about to expire
    // Return false otherwise
    // You might need to store the token's expiration timestamp when you initially fetch it
    return false; // Placeholder implementation
  }

  Future<void> refreshTokenIfNeeded() async {
    try {
      String newAccessToken = await refreshAccessToken(refreshToken);
      dotenv.env['FCM_KEY'] = newAccessToken;
    } catch (error) {
      log("Token refresh failed: $error");
    }
  }

  Future<String> refreshAccessToken(String refreshToken) async {


    try {
      var response = await dio.post(
        "https://oauth2.googleapis.com/token",
        data: {
          "client_id": "YOUR_CLIENT_ID",
          "client_secret": "YOUR_CLIENT_SECRET",
          "refresh_token": refreshToken,
          "grant_type": "refresh_token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        return data['access_token'];
      } else {
        throw Exception("Token refresh failed");
      }
    } catch (error) {
      throw Exception("Token refresh failed: $error");
    }
  }

  Future<dynamic> sendMessage({
    required String title,
    required String body,
    required String userDeviceToken,
  }) async {
    try {
      var response = await dio.post(
        "/messages:send",
        data: jsonEncode({
          "message": {
            "token": userDeviceToken,
            "notification": {
              "body": body,
              "title": title,
            },
          },
        }),
      );
      log("response data: ${jsonEncode(response.data)}");
    } catch (error) {
      log("error here: $error");
    }
  }
}
