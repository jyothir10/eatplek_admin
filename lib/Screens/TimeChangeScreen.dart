import 'dart:convert';

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Components/PlainButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Exceptions/api_exception.dart';

class TimeChangeScreen extends StatefulWidget {
  static const String id = '/time_change';
  const TimeChangeScreen({Key? key}) : super(key: key);

  @override
  State<TimeChangeScreen> createState() => _TimeChangeScreenState();
}

class _TimeChangeScreenState extends State<TimeChangeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var items = ["Open", "Closed"];
  String dropdownvalue = 'Open', msg = "", open_time = "", close_time = "";
  bool open = true, showSpinner = true;
  bool setTimer = false;
  bool isOpen = true;
  int oth = 1;
  int otm = 0;
  int cth = 1;
  int ctm = 0;
  int openhr = 2;
  int closehr = 2;
  int openmin = 5;
  int closemin = 5;
  final list = ['AM', 'PM'];
  String dropdownval = "AM";
  final list1 = ['AM', 'PM'];
  String dropdownval1 = "AM";
  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String day = 'Monday';
  final days1 = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String day1 = 'Monday', openingTime = "", closingTime = "";
  List opendays = [];
  static const except = {'exc': 'An error occured'};

  getRestaurantStatus() async {
    showSpinner = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/timings');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      isOpen = jsonData['timings']['open'];
      openingTime = jsonData['timings']['opening_time'];
      closingTime = jsonData['timings']['closing_time'];
      setState(() {
        if (!isOpen) {
          dropdownvalue = "Closed";
        }
        showSpinner = false;
      });
    } else
      APIException(response.statusCode, except);
  }

  timeChange(List dayList) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    String? token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };

    Map body1 = {
      "days_open": dayList,
      "opening_time": open_time,
      "closing_time": close_time,
      "open": open,
    };

    final body = jsonEncode(body1);

    var urlfinal = Uri.https(URL_Latest, '/restaurant/timings');

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      msg = await jsonData['message'];

      if (msg == "timings updated") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              msg,
            ),
          ),
        );
        getRestaurantStatus();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(
            "Error!",
          ),
        ),
      );
      APIException(response.statusCode, except);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getRestaurantStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Color(0xff000000),
          ),
        ),
        title: const Text("Time Change",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
                fontFamily: "SFUIText",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.left),
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
              padding: const EdgeInsets.only(top: 18, left: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.5,
                                fontFamily: 'SFUIText',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: 33,
                                decoration: BoxDecoration(
                                  color: dropdownvalue == "Open"
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(5.454545497894287),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: dropdownvalue,
                                      dropdownColor: const Color(0xff042e60),
                                      // Down Arrow Icon
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'SFUIText',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                          if (dropdownvalue == "Closed") {
                                            open = false;
                                            isOpen = false;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.5),
                              child: Text(
                                "Opening Time : $openingTime",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.5,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ),
                            Text(
                              "Closing Time : $closingTime",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.5,
                                fontFamily: 'SFUIText',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          setTimer == false
                              ? const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 14,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 14,
                                ),
                          const Text(
                            'Update Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.5,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Switch(
                              value: setTimer,
                              onChanged: (value) {
                                setState(() {
                                  setTimer = value;
                                });
                              },
                              activeColor: Color(0xffFFB800),
                              inactiveThumbColor: Colors.black12,
                              inactiveTrackColor: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                      setTimer == true
                          ? Container(
                              height: 230,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 9, top: 21),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Opening Time',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'SFUIText',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'Closing Time',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'SFUIText',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Text(
                                            'From',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'SFUIText',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'To',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'SFUIText',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(0.0,
                                                            1.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: NumberPicker(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    selectedTextStyle:
                                                        const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    zeroPad: true,
                                                    haptics: true,
                                                    infiniteLoop: true,
                                                    value: openhr,
                                                    minValue: 01,
                                                    maxValue: 12,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        openhr = value;
                                                        oth = openhr - 1;
                                                        if (oth == 0) {
                                                          oth = 12;
                                                        }
                                                        print(oth);
                                                      });
                                                    }),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9),
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(0.0,
                                                            1.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: NumberPicker(
                                                    zeroPad: true,
                                                    step: 5,
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    selectedTextStyle:
                                                        const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    haptics: true,
                                                    infiniteLoop: true,
                                                    value: openmin,
                                                    minValue: 0,
                                                    maxValue: 59,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        openmin = value;
                                                        otm = openmin - 5;
                                                        if (otm == -5) {
                                                          otm = 55;
                                                        }
                                                        print(otm);
                                                      });
                                                    }),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18),
                                                child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset: Offset(
                                                                    0.0,
                                                                    1.0), // shadow direction: bottom right
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                    child: Center(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          iconSize: 0,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'SFUIText',
                                                          ),
                                                          value: dropdownval,
                                                          items: list.map(
                                                              (String items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child:
                                                                  Text(items),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              dropdownval =
                                                                  newValue!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(0.0,
                                                            1.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: NumberPicker(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    selectedTextStyle:
                                                        const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    zeroPad: true,
                                                    haptics: true,
                                                    infiniteLoop: true,
                                                    value: closehr,
                                                    minValue: 1,
                                                    maxValue: 12,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        closehr = value;
                                                        cth = closehr - 1;
                                                        if (cth == 0) {
                                                          cth = 12;
                                                        }
                                                      });
                                                    }),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9),
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(0.0,
                                                            1.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: NumberPicker(
                                                    zeroPad: true,
                                                    step: 5,
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    selectedTextStyle:
                                                        const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    haptics: true,
                                                    infiniteLoop: true,
                                                    value: closemin,
                                                    minValue: 0,
                                                    maxValue: 59,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        closemin = value;
                                                        ctm = closemin - 5;
                                                        if (ctm == -5) {
                                                          ctm = 55;
                                                        }
                                                      });
                                                    }),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18),
                                                child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset: Offset(
                                                                    0.0,
                                                                    1.0), // shadow direction: bottom right
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                    child: Center(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          iconSize: 0,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'SFUIText',
                                                          ),
                                                          value: dropdownval1,
                                                          items: list1.map(
                                                              (String items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child:
                                                                  Text(items),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              dropdownval1 =
                                                                  newValue!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height: 35,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 1.0,
                                                      spreadRadius: 0.0,
                                                      offset: Offset(0.0,
                                                          1.0), // shadow direction: bottom right
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'SFUIText',
                                                    ),
                                                    value: day,
                                                    items: days
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(items),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        day = newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 1.0,
                                                    spreadRadius: 0.0,
                                                    offset: Offset(0.0,
                                                        1.0), // shadow direction: bottom right
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'SFUIText',
                                                  ),
                                                  value: day1,
                                                  items:
                                                      days1.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      day1 = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .41,
                          child: PlainButton(
                              text: "Cancel",
                              onTap: () {
                                //todo: cancel
                                Navigator.pop(context);
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .41,
                          child: BlueButton(
                            text: "Save",
                            onTap: () {
                              if (oth < 10) {
                                if (otm < 10) {
                                  open_time = "0$oth:0$otm $dropdownval";
                                } else {
                                  open_time = "0$oth:$otm $dropdownval";
                                }
                              } else {
                                open_time = "$oth:$otm $dropdownval";
                              }
                              if (cth < 10) {
                                if (ctm < 10) {
                                  close_time = "0$cth:0$ctm $dropdownval1";
                                } else {
                                  close_time = "0$cth:$ctm $dropdownval1";
                                }
                              } else {
                                close_time = "$cth:$ctm $dropdownval1";
                              }

                              int startDay = 1;
                              int endDay = 7;
                              List dayList = [];
                              switch (day) {
                                case "Monday":
                                  startDay = 0;
                                  break;
                                case "Tuesday":
                                  startDay = 1;
                                  break;
                                case "Wednesday":
                                  startDay = 2;
                                  break;
                                case "Thursday":
                                  startDay = 3;
                                  break;
                                case "Friday":
                                  startDay = 4;
                                  break;
                                case "Saturday":
                                  startDay = 5;
                                  break;
                                case "Sunday":
                                  startDay = 6;
                                  break;
                              }
                              switch (day1) {
                                case "Monday":
                                  endDay = 0;
                                  break;
                                case "Tuesday":
                                  endDay = 1;
                                  break;
                                case "Wednesday":
                                  endDay = 2;
                                  break;
                                case "Thursday":
                                  endDay = 3;
                                  break;
                                case "Friday":
                                  endDay = 4;
                                  break;
                                case "Saturday":
                                  endDay = 5;
                                  break;
                                case "Sunday":
                                  endDay = 6;
                                  break;
                              }
                              for (int i = startDay; i <= endDay; i++) {
                                dayList.add(days[i]);
                              }
                              timeChange(dayList);
                            },
                          ),
                        )
                      ],
                    ),
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
