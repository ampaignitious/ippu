import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ippu/main.dart';
import 'package:ippu/services/overlay_edited.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print('Body: ${message.notification!.body}');
  print('Title: ${message.notification!.title}');
  print('Payload: ${message.data}');
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



  void handleMessage(RemoteMessage? message){
    if(message == null) return;

    navigatorKey.currentState!.pushNamed(
      '/homescreen',
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');

    const settings = InitializationSettings(iOS: iOS, android: android);

   await _localNotifications.initialize(
    settings,
    onDidReceiveNotificationResponse: (payload) async {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload as String));
        handleMessage(message);
    }
);


    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

Future<void> initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  FirebaseMessaging.onBackgroundMessage((message) async {
    // Handle the background message
    handleBackgroundMessage(message);
  });

  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;

    // Show the notification
    showSimpleNotification(
      Text(notification.title!),
      leading: Image.network(
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fwww.ippu.or.ug%2F&psig=AOvVaw2d-L8NWGxlpveidwHjkH6V&ust=1700722443705000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCMD8mfmC14IDFQAAAAAdAAAAABAE",
        fit: BoxFit.cover,
      ),
      subtitle: Text(notification.body!),
      background: Colors.white,
      duration: const Duration(seconds: 4),
      autoDismiss: false,
      slideDismissDirection: DismissDirection.up,
    );
  });
}



  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
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