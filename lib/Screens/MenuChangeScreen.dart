import 'dart:convert';

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  var restaurant;
  String? id;
  String resname = "";
  String dropdownvalue = "item1";
  var items = ['item1', 'item2'];
  static const except = {'exc': 'An error occured'};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getRestaurant() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    id = sharedpreferences.getString("id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/$id'); //todo:change id.

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

  requestAddItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/request');

    print(urlfinal);

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

    print(response.body);
    print(response.statusCode);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      print("Hello");
      final jsonData = await jsonDecode(response.body);
      print(jsonData);
      print(jsonData['message']);

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
    //todo: Update item API
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/request');

    print(urlfinal);

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

    print(response.body);
    print(response.statusCode);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      print("Hello");
      final jsonData = await jsonDecode(response.body);
      print(jsonData);
      print(jsonData['message']);

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

  @override
  void initState() {
    // TODO: implement initState
    getRestaurant();
    super.initState();
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
      body: SingleChildScrollView(
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
                    height: 246,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Text(
                                      'Rate',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * .49,
                                    child: TextField(
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
                                            controller: ratecontroller,
                                            cursorColor: primaryClr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: 'SFUIText',
                                            ),
                                            keyboardType: TextInputType.number,
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
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        .633,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
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
                                        contentPadding:
                                            EdgeInsets.only(left: 5, right: 3),
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
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                    height: 193,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 28),
                                child: Text(
                                  'Rate',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * .49,
                                decoration: BoxDecoration(
                                  color: Color(0xff17000000),
                                  borderRadius: BorderRadius.circular(5),
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
                                        iconEnabledColor: Color(0xff8a8a8a),
                                        iconDisabledColor: Color(0xff8a8a8a),
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: 'SFUIText',
                                        ),
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownvalue = value!;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: 'SFUIText',
                                        ),
                                        keyboardType: TextInputType.number,
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
                              Container(
                                width: MediaQuery.of(context).size.width * .633,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'SFUIText',
                                    height: 1.5,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    filled: true,
                                    fillColor: Color(0xff17000000),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
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
                                    ),
                                  ),
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
    );
  }
}
