import 'package:eatplek_admin/Components/LoginButton.dart';
import 'package:eatplek_admin/Components/LoginScreenTextField.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";
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

  Color buttonColour = Color(0xffc6c6cc);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff042e60),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Image(
                        image: AssetImage("images/logo.png"),
                        width: MediaQuery.of(context).size.width * .717,
                        height: MediaQuery.of(context).size.height * .372,
                      )
                    : Container(),
                const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: [
                    LoginScreenTextField(
                        text: "Username",
                        onchanged: (value) {
                          username = value;
                          if (username.isNotEmpty && password.isNotEmpty) {
                            setState(() {
                              buttonColour = Colors.white;
                            });
                          }
                        },
                        type: TextInputType.name,
                        obscure: false),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: LoginScreenTextField(
                        text: "Password",
                        onchanged: (value) {
                          password = value;
                          if (username.isNotEmpty && password.isNotEmpty) {
                            setState(() {
                              buttonColour = Colors.white;
                            });
                          }
                        },
                        type: TextInputType.name,
                        obscure: true,
                      ),
                    ),
                  ],
                ),
                LoginButton(
                  clr: buttonColour,
                  onPressed: () {
                    if (username.isNotEmpty && password.isNotEmpty) {
                      Navigator.pushReplacementNamed(
                          context, DashboardScreen.id);
                    } else {
                      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                          content: Text("Invalid username or password")));
                    }
                  },
                  text: 'Get OTP',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
