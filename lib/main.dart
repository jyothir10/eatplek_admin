import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:eatplek_admin/Screens/InventoryScreen.dart';
import 'package:eatplek_admin/Screens/InvoiceScreen.dart';
import 'package:eatplek_admin/Screens/OnboardingScreen.dart';
import 'package:eatplek_admin/Screens/ProfileScreen.dart';
import 'package:eatplek_admin/Screens/SettingsSCreen.dart';
import 'package:eatplek_admin/Screens/TimeChangeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/EditProfileScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MenuChangeScreen.dart';
import 'Screens/NotificationScreen.dart';
import 'Screens/RevenueScreen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: OnboardingScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          MenuChangeScreen.id: (context) => MenuChangeScreen(),
          TimeChangeScreen.id: (context) => TimeChangeScreen(),
          SettingsSCreen.id: (context) => SettingsSCreen(),
          InventoryScreen.id: (context) => InventoryScreen(),
          RevenueScreen.id: (context) => RevenueScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          InvoiceScreen.id: (context) => InvoiceScreen(
                orderId: "",
              ),
        });
  }
}
