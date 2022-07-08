import 'package:eatplek_admin/Screens/InventoryScreen.dart';
import 'package:eatplek_admin/Screens/OnboardingScreen.dart';
import 'package:eatplek_admin/Screens/SettingsSCreen.dart';
import 'package:eatplek_admin/Screens/TimeChangeScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/EditProfileScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MenuChangeScreen.dart';
import 'Screens/NotificationScreen.dart';
import 'Screens/ExpensesScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ExpensesScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          MenuChangeScreen.id: (context) => MenuChangeScreen(),
          TimeChangeScreen.id: (context) => TimeChangeScreen(),
          SettingsSCreen.id: (context) => SettingsSCreen(),
          InventoryScreen.id: (context) => InventoryScreen(),
          ExpensesScreen.id: (context) => ExpensesScreen(),
        });
  }
}
