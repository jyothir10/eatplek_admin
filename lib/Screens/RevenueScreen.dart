import 'dart:convert';

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class RevenueScreen extends StatefulWidget {
  static const String id = '/expenses';

  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController startdateInput = TextEditingController();
  TextEditingController enddateInput = TextEditingController();
  String startDate = "", endDate = "";
  bool isEmpty1 = false;
  bool showList1 = false, showSpinner = false;
  static const except = {'exc': 'An error occured'};
  String total = "0";
  int noOfOrders = 0;
  List orders = [];
  getRevenue() async {
    setState(() {
      showSpinner = true;
    });
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };

    Map body1 = {
      "start_date": startDate,
      "end_date": endDate,
    };

    final body = jsonEncode(body1);

    var urlfinal = Uri.https(URL_Latest, '/hotel/revenue'); //todo:change id.

    http.Response response =
        await http.post(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      total = jsonData['Total'].toString();

      if (jsonData['Orders'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else if (jsonData['Orders'].length == 0) {
        isEmpty1 = true;
        showList1 = true;
        orders = [];
        noOfOrders = 0;
      } else {
        showList1 = true;
        orders = jsonData['Orders'];
        noOfOrders = orders.length;
      }
      setState(() {
        showSpinner = false;
      });
    } else {
      isEmpty1 = true;
      showList1 = true;
      APIException(response.statusCode, except);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff042e60),
            title: const Text(
              'Revenue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'SFUIText',
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, DashboardScreen.id);
            return false;
          },
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 70,
                  child: Center(
                    child: TextField(
                      controller: startdateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Start Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          startDate = pickedDate.toIso8601String();
                          startDate += "+00:00";
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          setState(() {
                            startdateInput.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  height: 70,
                  child: Center(
                    child: TextField(
                      controller: enddateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "End Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          endDate = pickedDate.toIso8601String();
                          endDate += "+00:00";
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          setState(() {
                            enddateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlueButton(
                          text: "Show Revenue",
                          onTap: () {
                            if (startDate.isNotEmpty && endDate.isNotEmpty) {
                              getRevenue();
                            } else {
                              _scaffoldKey.currentState?.showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                    "Enter start date and end date.",
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            color: Color(0xffe6e6e6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Total Revenue',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 8,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      total.toString(),
                                      style: const TextStyle(
                                        color: Color(0xff1d1d1d),
                                        fontSize: 18.8,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Total number\n    of orders',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 7,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      noOfOrders.toString(),
                                      style: const TextStyle(
                                        color: Color(0xff1d1d1d),
                                        fontSize: 14,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: SizedBox(
                            height: 15,
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height - 500,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  return ExpenseScreenCard(
                                    name: orders[index]['name'].toString(),
                                    price:
                                        orders[index]['totalamount'].toString(),
                                    noOfItems: orders[index]['numberofitems']
                                        .toString(),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(
          index: 2,
        ),
      ),
    );
  }
}

class ExpenseScreenCard extends StatelessWidget {
  final String name;
  final String price;
  final String noOfItems;

  const ExpenseScreenCard({
    required this.name,
    required this.price,
    required this.noOfItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: Color(0xffe6e6e6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$noOfItems items',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Transform.rotate(
                  //   angle: 270 * math.pi / 180,
                  //   child: const Icon(
                  //     Icons.arrow_drop_down_circle_outlined,
                  //     color: Colors.black,
                  //     size: 13,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
