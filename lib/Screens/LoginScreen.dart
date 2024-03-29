import 'dart:convert';

import 'package:eatplek_admin/Components/LoginButton.dart';
import 'package:eatplek_admin/Components/LoginScreenTextField.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';
import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String username = "";
  String password = "";
  bool status = false;
  bool showSpinner = false;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  signin() async {
    setState(() {
      showSpinner = true;
      FocusManager.instance.primaryFocus?.unfocus();
    });
    String url = "${URL_Latest}/restaurant/login/";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    Map body1 = {
      "username": namecontroller.text.trim(),
      "password": passwordcontroller.text.trim()
    };

    final body = jsonEncode(body1);

    var urlfinal = Uri.http(URL_Latest, '/restaurant/login');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      final token = await responseBody["result"]["token"];
      final id = await responseBody["result"]["id"];

      sharedPreferences.setString("token", token);
      sharedPreferences.setString("id", id);

      namecontroller.clear();
      passwordcontroller.clear();

      setState(() {
        showSpinner = false;
      });

      if (token != null) {
        Navigator.pushReplacementNamed(context, DashboardScreen.id);
      } else {
        if (status == false) {
          namecontroller.clear();
          passwordcontroller.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
              content: Text(
                "Could not login, username/password incorrect!",
              ),
            ),
          );
          setState(() {
            showSpinner = false;
          });
        }
        throw APIException(res.statusCode, jsonDecode(res.body));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(
            "Incorrect username or password",
          ),
        ),
      );
      setState(() {
        showSpinner = false;
      });
      throw APIException(res.statusCode, jsonDecode(res.body));
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  Color buttonColour = Color(0xffc6c6cc);

  @override
  void dispose() {
    namecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Colors.white,
          ),
          color: primaryClr,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff042e60),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Hero(
                          tag: "logo",
                          child: SvgPicture.asset(
                            "images/042e60.svg",
                            width: MediaQuery.of(context).size.width * .717,
                            height: MediaQuery.of(context).size.height * .372,
                          ),
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
                          maxLength: 33,
                          controller: namecontroller,
                          text: "Username",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]")),
                          ],
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
                          maxLength: 30,
                          controller: passwordcontroller,
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
                        signin();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                                content: Text("Invalid username or password")));
                      }
                    },
                    text: 'Log In',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
