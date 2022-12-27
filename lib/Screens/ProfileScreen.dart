import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/BlueButton.dart';
import '../Constants.dart';
import 'DashBoardScreen.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String msg = "", name = "";
  bool showSpinner = true, fetched = false;
  var profile = null;

  getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? resid = sharedPreferences.getString("id");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/$resid');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      msg = await jsonData['message'];
      if (msg == "restaurant found") {
        profile = await jsonData['restaurant'];
        name = profile['name'];
      }

      setState(() {
        showSpinner = false;
        fetched = true;
      });
    }
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, DashboardScreen.id);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryClr,
          ),
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: profile != null && fetched == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffefeeee),
                            radius: 51.2,
                            child: name.isNotEmpty
                                ? Text(
                                    profile['name'][0].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35.826087951660156,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    "U",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35.826087951660156,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: name.isNotEmpty
                                ? Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    "User",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    profile['email'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  color: Color(0xff585757),
                                  size: 9,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: profile['phone'].toString().isNotEmpty
                                      ? Text(
                                          profile['phone'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontFamily: 'SFUIText',
                                          ),
                                        )
                                      : Text(
                                          "+91 xxxxxxxxxx",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontFamily: 'SFUIText',
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 90),
                            child: BlueButton(
                              text: '       Log Out       ',
                              onTap: () {
                                logout();
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.id);
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: fetched == true && profile == null
                            ? Text(
                                "Unable to fetch profile information",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0,
                                ),
                              )
                            : Container(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
