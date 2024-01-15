import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ippu/main.dart';
import 'package:ippu/services/overlay_edited.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState!.pushNamed(
      '/homescreen',
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');

    const settings = InitializationSettings(iOS: iOS, android: android);

    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) async {
      final message =
          RemoteMessage.fromMap(jsonDecode(payload.payload as String));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotifications() async {
    
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage((message) async {
    // Handle the background message
    await handleBackgroundMessage(message);
  });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                icon: '@drawable/ic_launcher',
              ),
            ));
      }
    });
  }

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    //save the token to the shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fcmToken!);
    initPushNotifications();
    initLocalNotifications();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Process the notification payload here
    print('Handling a background message ${message.messageId}');
    print('Body: ${message.notification!.body}');
    print('Title: ${message.notification!.title}');
    print('Payload: ${message.data}');

    // Show a local notification if necessary
    final notification = message.notification;
    if (notification != null) {
      await _localNotifications.show(
        0,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            icon: '@drawable/ic_launcher',
          ),
        ),
      );
    }
  }
}
