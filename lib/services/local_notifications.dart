import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialise() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      print(payload);
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
