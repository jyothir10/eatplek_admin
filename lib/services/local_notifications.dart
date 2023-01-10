import 'package:eatplek_admin/Screens/NotificationScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialise() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      BuildContext? context = navigatorKey.currentState?.context;
      if (context != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
      }
    });
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.eatpleadmin.eatplek", "Eatplek-Admin",
            importance: Importance.max, priority: Priority.high));
    _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification?.title,
        message.notification?.body,
        notificationDetails);
  }
}
