import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_plans/core/local/storage.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_constant.dart';

import '../../models/advance_model.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocaleNotificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setupFCM() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        sound: true);

    // Get the token
    String? token = await _firebaseMessaging.getToken();
    log('FCM Token: $token');

    localNotificationInit();
    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      log('Received FCM message: ${message.notification?.title}');
      if (message.notification != null) {
        FCMService.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    });

    // Handle when the app is in the background and the user taps the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);

      log('App opened from FCM notification: ${message.notification?.title}');
      if (message.notification != null) {
        print("Background Notification Tapped");
        AppConstants.navigatorKey.currentState!.pushNamed(AppRoute.notificationRoute, arguments: message);
      }
    });
  }

  Future localNotificationInit() async {

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocaleNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static Future<void> onNotificationTap(NotificationResponse notificationResponse) async {
    await AppStorage.init(null);
    if (AdvanceModel.rememberMe && AdvanceModel.token != "") {
      AppConstants.navigatorKey.currentState!
          .pushNamed(AppRoute.notificationRoute, arguments: notificationResponse);
    }



  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocaleNotificationPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> showLocalNotification({required String title,required String description}) async {
    // Initialize settings for Android and iOS
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/launcher_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocaleNotificationPlugin.initialize(initializationSettings);

    // Set notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'smart_plants_id', // Change this to your channel ID
      'alert', // Change this to your channel name
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,

    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Display the notification
    await _flutterLocaleNotificationPlugin.show(
      0, // Change this to a unique ID for each notification
      '${title}', // Change this to your notification title
      '${description}', // Change this to your notification body
      platformChannelSpecifics,
    );
  }
}
