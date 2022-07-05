import 'package:flutter/material.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/NotificationScreen.dart';
import 'Screens/EditProfileScreen.dart';
import 'Screens/MenuChangeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MenuChangeScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          MenuChangeScreen.id: (context) => MenuChangeScreen(),
        });
  }
}
