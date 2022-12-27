import 'dart:convert';

import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class InventoryScreen extends StatefulWidget {
  static const String id = '/invent';
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  bool expanded = false;
  bool setFries = false;
  int outofstock = 2;
  List foods = [];
  List categories = [];
  List categorylist = [];
  List categoryids = [];
  static const except = {'exc': 'An error occured'};
  bool showSpinner = true;
  bool isEmpty1 = false;
  bool showList1 = false;
  bool isCategory = false;
  List<bool> fries = [false, false, false];

  var categorymap = {};

  getFood() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/food/filter/restaurant/$id');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['foods'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else {
        foods = await jsonData['foods'];
        showList1 = true;
        categories.clear();
        categoryids.clear();
        categorylist.clear();
        for (int i = 0; i < foods.length; i++) {
          categories.add(foods[i]['category_name']);
          categorylist.add(foods[i]['category_name']);
          categoryids.add(foods[i]['category_id']);
        }
      }

      setState(() {
        showSpinner = false;
      });
    } else
      APIException(response.statusCode, except);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFood();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashboardScreen.id);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * .107),
          child: AppBar(
            backgroundColor: primaryClr,
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, DashboardScreen.id);
              },
              child: const Icon(
                Icons.arrow_back_outlined,
              ),
            ),
            title: const Text(
              'Inventory',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'SFUIText',
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.search_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryClr,
          ),
          child: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(context, DashboardScreen.id);
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight),
                    child: isEmpty1 == false
                        ? ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return InventoryItem(
                                on: false,
                                category: categories[index],
                                categoryId: categoryids[index],
                              );
                            })
                        : Container(
                            child: Center(
                              child: Text("No data to show"),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(
          index: 1,
        ),
      ),
    );
  }
}

class InventoryItem extends StatefulWidget {
  bool on;
  String category;
  String categoryId;

  InventoryItem(
      {Key? key,
      required this.on,
      required this.category,
      required this.categoryId})
      : super(key: key);

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  bool isEmpty = false;
  bool showList = false;
  List foods = [];
  static const except = {'exc': 'An error occured'};

  getCategoryFood(String categoryId) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    setState(() {
      isEmpty = false;
      showList = false;
    });

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final Map<String, String> _queryParameters = <String, String>{
      'category': categoryId,
    };
    var urlfinal =
        Uri.https(URL_Latest, '/food/filter/restaurant/$id', _queryParameters);

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['foods'] == null) {
        isEmpty = true;
        showList = true;
      } else {
        foods = await jsonData['foods'];
        showList = true;
        print(foods);
      }
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  widget.on
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_right_outlined,
                  size: 18,
                  color: widget.on ? Colors.black : Color(0x7f000000),
                ),
                Text(
                  widget.category,
                  style: TextStyle(
                    color: widget.on ? Colors.black : Color(0x7f000000),
                    fontSize: 13,
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Switch(
              value: widget.on,
              onChanged: (value) {
                getCategoryFood(widget.categoryId);
                setState(() {
                  widget.on = value;
                });
              },
              activeColor: Color(0xffffb800),
              activeTrackColor: Color(0xfff0ecec),
            ),
          ],
        ),
        widget.on
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  child: isEmpty
                      ? Container()
                      : Container(
                          child: showList
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: ListView.builder(
                                      itemCount: foods.length,
                                      itemBuilder: (context, index) {
                                        return InventoryItems(
                                          isAvail: foods[index]['is_available'],
                                          foodName: foods[index]['name'],
                                          foodId: foods[index]['id'],
                                        );
                                      }),
                                )
                              : SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: primaryClr,
                                  ),
                                ),
                        ),
                ))
            : Container(),
      ],
    );
  }
}

class InventoryItems extends StatefulWidget {
  bool isAvail;
  String foodName;
  String foodId;

  InventoryItems({
    Key? key,
    required this.isAvail,
    required this.foodName,
    required this.foodId,
  }) : super(key: key);

  @override
  State<InventoryItems> createState() => _InventoryItemsState();
}

class _InventoryItemsState extends State<InventoryItems> {
  changeAvail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/food/availability/${widget.foodId}');

    http.Response response = await http.put(urlfinal, headers: headers);
    print(response.body);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isAvail ? Colors.black : Color(0x7f000000),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.circle,
                size: 5,
                color: widget.isAvail ? Colors.black : Color(0x7f000000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.foodName,
                style: TextStyle(
                  color: widget.isAvail ? Colors.black : Color(0x7f000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Switch(
              value: widget.isAvail,
              onChanged: (value) {
                changeAvail();
                setState(() {
                  widget.isAvail = value;
                });
              },
              activeColor: Color(0xffffb800),
              activeTrackColor: Color(0xfff0ecec),
            ),
          ],
        )
      ],
    );
  }
}
