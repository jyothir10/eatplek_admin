import 'dart:math' as math;

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatefulWidget {
  static const String id = '/expenses';

  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  TextEditingController dateInput = TextEditingController();
  String startDate = "", endDate = "";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, DashboardScreen.id);
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: TextField(
                      controller: dateInput,
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
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            dateInput.text = formattedDate;
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
                  height: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: TextField(
                      controller: dateInput,
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
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlueButton(text: "Show Revenue", onTap: () {}),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .084,
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
                                  children: const [
                                    Text(
                                      'Today’s Revenue',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 8,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      '₹ 4500',
                                      style: TextStyle(
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
                                  children: const [
                                    Text(
                                      'Total number\n    of orders',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 7,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      '14',
                                      style: TextStyle(
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
                        const ExpenseScreenCard(
                          name: 'Vinod Kumar ',
                          price: '₹ 520',
                        ),
                        const ExpenseScreenCard(
                          name: 'Vinod Kumar ',
                          price: '₹ 520',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .084,
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
                                  children: const [
                                    Text(
                                      'Today’s Revenue',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 7.849205017089844,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      '₹ 4500',
                                      style: TextStyle(
                                        color: Color(0xff1d1d1d),
                                        fontSize: 18.838092803955078,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      'Total number\n    of orders',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 6.906872272491455,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                    Text(
                                      '14',
                                      style: TextStyle(
                                        color: Color(0xff1d1d1d),
                                        fontSize: 13.81374454498291,
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
                          child: Text(
                            'Orders',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const ExpenseScreenCard(
                          name: 'Vinod Kumar ',
                          price: '₹ 520',
                        ),
                        const ExpenseScreenCard(
                          name: 'Vinod Kumar ',
                          price: '₹ 520',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(),
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

  const ExpenseScreenCard({
    required this.name,
    required this.price,
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
                  const Text(
                    '2 items',
                    style: TextStyle(
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
                  Transform.rotate(
                    angle: 270 * math.pi / 180,
                    child: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.black,
                      size: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
