import 'package:flutter/material.dart';

class TimeChangeScreen extends StatefulWidget {
  static const String id = '/time_change';
  const TimeChangeScreen({Key? key}) : super(key: key);

  @override
  State<TimeChangeScreen> createState() => _TimeChangeScreenState();
}

class _TimeChangeScreenState extends State<TimeChangeScreen> {
  var items = ["Open", "Closed"];
  String dropdownvalue = 'Open';
  bool open = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                fontSize: 14.0),
            textAlign: TextAlign.left),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 27),
                  child: Row(
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: dropdownvalue == "Open"
                                ? Colors.green
                                : Colors.red,
                            borderRadius:
                                BorderRadius.circular(5.454545497894287),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
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
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 12,
                    ),
                    Text(
                      'Set Timer',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
