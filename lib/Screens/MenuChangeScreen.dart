import 'dart:convert';

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class MenuChangeScreen extends StatefulWidget {
  static const String id = '/MenuChange';
  const MenuChangeScreen({Key? key}) : super(key: key);

  @override
  State<MenuChangeScreen> createState() => _MenuChangeScreenState();
}

class _MenuChangeScreenState extends State<MenuChangeScreen> {
  bool expanded1 = false;
  bool expanded2 = false;
  bool showSpinner = true;
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  TextEditingController updateACRateController = TextEditingController();
  TextEditingController updateNonacRateController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();
  var restaurant;
  String? id;
  String resname = "";
  String dropdownvalue = "";
  int index = 0;
  var items = ['item1', 'item2'];
  var foods = [];
  List<String> foodNames = [];
  var foodIds = [];
  static const except = {'exc': 'An error occured'};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getRestaurant() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/$id');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      restaurant = await jsonData['restaurant'];
      if (restaurant.length != 0) {
        resname = restaurant['name'];
      }
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  getAllFoods() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final Map<String, String> _queryParameters = <String, String>{
      'foredit': 'true',
    };
    var urlfinal = Uri.https(URL_Latest, '/food/filter/restaurant/$id',
        _queryParameters); //todo: change res id.

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      foods = jsonData['foods'];
      for (int i = 0; i < foods.length; i++) {
        foodIds.add(foods[i]['id'].toString());
        foodNames.add(foods[i]['name'].toString());
      }
      setState(() {
        dropdownvalue = foodNames[0];
        showSpinner = false;
      });
    } else
      APIException(response.statusCode, except);
  }

  requestAddItem() async {
    FocusManager.instance.primaryFocus?.unfocus();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/request');

    Map body1 = {
      "user_id": sharedPreferences.getString("id"),
      "name": itemnamecontroller.text.trim(),
      "price": ratecontroller.text.trim(),
      "description": descriptioncontroller.text.trim(),
      "restaurant": resname,
      "restaurant_id": id
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.post(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "request created") {
        _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Successfully placed add item request",
            ),
          ),
        );
        itemnamecontroller.clear();
        ratecontroller.clear();
        descriptioncontroller.clear();
      } else {
        _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Error in placing add item request",
            ),
          ),
        );
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  requestUpdateItem() async {
    FocusManager.instance.primaryFocus?.unfocus();
    String foodid = foodIds[index];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/food/$foodid');

    Map body1 = {
      "name": dropdownvalue,
      "description": updateDescriptionController.text.trim(),
      "non_ac_price": updateNonacRateController.text.trim(),
      "ac_price": updateACRateController.text.trim(),
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "food updated") {
        _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Successfully updated item",
            ),
          ),
        );
        updateDescriptionController.clear();
        updateACRateController.clear();
        updateNonacRateController.clear();
      } else {
        _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Error in updating item ",
            ),
          ),
        );
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  @override
  void initState() {
    // TODO: implement initState
    getRestaurant();
    getAllFoods();
    super.initState();
  }

  @override
  void dispose() {
    itemnamecontroller.dispose();
    ratecontroller.dispose();
    descriptioncontroller.dispose();
    updateDescriptionController.dispose();
    updateACRateController.dispose();
    updateNonacRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff1A191A),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Menu Change',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: const CircularProgressIndicator(
          color: primaryClr,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (expanded1 == true) {
                            expanded1 = false;
                          } else {
                            expanded1 = true;
                          }
                        });
                      },
                      child: Container(
                        color: Color(0xfffff5f5),
                        height: MediaQuery.of(context).size.height * .0475,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Icon(
                                expanded1
                                    ? Icons.keyboard_arrow_down_outlined
                                    : Icons.keyboard_arrow_right_outlined,
                                size: 18,
                              ),
                              const Text(
                                'Adding New item',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              expanded1
                  ? Container(
                      color: Colors.white,
                      height: 255,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .49,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: itemnamecontroller,
                                          cursorColor: primaryClr,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                          ),
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xff17000000),
                                            contentPadding: EdgeInsets.all(5),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            hintText: "Name of new item",
                                            hintStyle: const TextStyle(
                                              color: Color(0xff8a8a8a),
                                              fontSize: 12,
                                              fontFamily: 'SFUIText',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rate',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'RS  ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .15,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller: ratecontroller,
                                                cursorColor: primaryClr,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: 'SFUIText',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      Color(0xff17000000),
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  hintText: "Rate",
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xff8a8a8a),
                                                    fontSize: 12,
                                                    fontFamily: 'SFUIText',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .633,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: descriptioncontroller,
                                          cursorColor: primaryClr,
                                          style: const TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 5, right: 3),
                                            filled: true,
                                            fillColor: Color(0xff17000000),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            hintText: "Short description",
                                            hintStyle: const TextStyle(
                                              color: Color(0xff8a8a8a),
                                              fontSize: 12,
                                              fontFamily: 'SFUIText',
                                              height: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 2, top: 15),
                                  child: BlueButton(
                                    text: "Add Item",
                                    onTap: () {
                                      requestAddItem();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 13,
                    ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (expanded2 == true) {
                      expanded2 = false;
                    } else {
                      expanded2 = true;
                    }
                  });
                },
                child: Container(
                  color: Color(0xfffff5f5),
                  height: MediaQuery.of(context).size.height * .0475,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Icon(
                          expanded2
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_right_outlined,
                          size: 18,
                        ),
                        const Text(
                          'Change Exisiting Item Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.387463569641113,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              expanded2
                  ? Container(
                      color: Colors.white,
                      height: 315,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .49,
                                        decoration: BoxDecoration(
                                          color: Color(0xff17000000),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButton(
                                                hint: const Text(
                                                  'Name of item',
                                                  style: TextStyle(
                                                    color: Color(0xff8a8a8a),
                                                    fontSize: 12,
                                                    fontFamily: 'SFUIText',
                                                  ),
                                                ),
                                                value: dropdownvalue,
                                                iconSize: 18,
                                                iconEnabledColor:
                                                    Color(0xff8a8a8a),
                                                iconDisabledColor:
                                                    Color(0xff8a8a8a),
                                                icon: const Icon(Icons
                                                    .keyboard_arrow_down_outlined),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: 'SFUIText',
                                                ),
                                                items: foodNames
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    dropdownvalue = value!;
                                                    index = foodNames
                                                        .indexOf(dropdownvalue);
                                                  });
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'AC Rate',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'RS  ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .15,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: TextField(
                                                controller:
                                                    updateACRateController,
                                                cursorColor: primaryClr,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: 'SFUIText',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      Color(0xff17000000),
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  hintText: "Rate",
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xff8a8a8a),
                                                    fontSize: 12,
                                                    fontFamily: 'SFUIText',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Non-AC Rate',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'RS  ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .15,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: TextField(
                                                controller:
                                                    updateNonacRateController,
                                                cursorColor: primaryClr,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: 'SFUIText',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      Color(0xff17000000),
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  hintText: "Rate",
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xff8a8a8a),
                                                    fontSize: 12,
                                                    fontFamily: 'SFUIText',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'SFUIText',
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .633,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller:
                                              updateDescriptionController,
                                          cursorColor: primaryClr,
                                          style: const TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 5, right: 3),
                                            filled: true,
                                            fillColor: Color(0xff17000000),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            hintText: "Short description",
                                            hintStyle: const TextStyle(
                                              color: Color(0xff8a8a8a),
                                              fontSize: 12,
                                              fontFamily: 'SFUIText',
                                              height: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 2, top: 15),
                                  child: BlueButton(
                                    text: "Update Item",
                                    onTap: () {
                                      requestUpdateItem();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
