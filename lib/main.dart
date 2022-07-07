import 'package:eatplek_admin/Screens/TimeChangeScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/EditProfileScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MenuChangeScreen.dart';
import 'Screens/NotificationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: TimeChangeScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          MenuChangeScreen.id: (context) => MenuChangeScreen(),
          TimeChangeScreen.id: (context) => TimeChangeScreen(),
        });
  }
}
