import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = '/splash';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      key: _scaffoldKey,
      onWillPop: onWillPop,
      child: EasySplashScreen(
        showLoader: false,
        backgroundColor: const Color(0xff042e60),
        logo: Image.asset(
          "images/logo.png",
        ),
        logoSize: MediaQuery.of(context).size.height * .43,
        navigator: LoginScreen(),
        durationInSeconds: 5,
      ),
    );
  }
}
// SplashScreen(
// navigateAfterSeconds: ,
// seconds: 5,
// backgroundColor:
// image:
// useLoader: false,
// photoSize: MediaQuery.of(context).size.height * .25,
// )
