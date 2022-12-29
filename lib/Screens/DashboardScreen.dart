import 'dart:convert';

import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Components/YellowButton.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:eatplek_admin/Screens/AllOrderScreen.dart';
import 'package:eatplek_admin/Screens/DelayedOrdersScreen.dart';
import 'package:eatplek_admin/Screens/DeliveredOrdersScreen.dart';
import 'package:eatplek_admin/Screens/PreparingScreen.dart';
import 'package:eatplek_admin/Screens/TimeChangeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var restaurant;
  List orders = [];
  bool isEmpty = false;
  bool showList = false;
  bool isEmpty1 = false;
  bool showList1 = false;
  bool open = true;
  int i = 0;
  static const except = {'exc': 'An error occured'};

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

  getRestaurant() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/$id');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      restaurant = await jsonData['restaurant'];

      if (restaurant.length == 0) {
        isEmpty = true;
        showList = true;
      } else {
        showList = true;
      }
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  getRestaurantStatus() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/status/$id');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      open = jsonData['open'];
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  @override
  void initState() {
    // TODO: implement initState
    getRestaurantStatus();
    getRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomBar(
            index: 0,
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryClr,
            title: const Text(
              'Order Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'SFUIText',
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(125),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  showList == true
                      ? Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width * .943,
                          decoration: BoxDecoration(
                            color: Color(0x23ffffff),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant["name"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SFUIText',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        restaurant["location"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    YellowButton(
                                        text: open ? "Open" : "Closed",
                                        onTap: () {}),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 7),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, TimeChangeScreen.id);
                                        },
                                        child: const Text(
                                          'Change',
                                          style: TextStyle(
                                            shadows: [
                                              Shadow(
                                                  color: Colors.white,
                                                  offset: Offset(0, -5))
                                            ],
                                            color: Colors.transparent,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color(0x23ffffff),
                                            decorationThickness: 5,
                                            fontSize: 9,
                                            fontFamily: 'SFUIText',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: CircularProgressIndicator(),
                        ),
                  (const TabBar(
                    indicatorColor: Color(0xff59f5ff),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'SFUIText',
                    ),
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Preparing",
                      ),
                      Tab(
                        text: "Delivered",
                      ),
                      Tab(
                        text: "Delay",
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AllOrderScreen(),
              PreparingScreen(),
              DeliveredOrdersScreen(),
              DelayedOrdersScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
