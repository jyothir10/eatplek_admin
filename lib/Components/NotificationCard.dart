import 'dart:convert';

import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCard extends StatefulWidget {
  String title, noOfGuests, type, time, description, userId;
  void Function()? onTap;

  NotificationCard({
    required this.title,
    required this.time,
    required this.type,
    required this.noOfGuests,
    required this.description,
    required this.userId,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  markDone(int status) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    Map body1 = {"userid": widget.userId, "status": status};

    final body = jsonEncode(body1);
    var urlfinal = Uri.https(URL_Latest, '/cart/status');

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      print(response.body);
      setState(() {
        widget.onTap!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * .885,
        height: MediaQuery.of(context).size.height * .19,
        // decoration: const BoxDecoration(
        //   color: Colors.white,
        //   border: Border(
        //     top: BorderSide(
        //       color: Colors.white,
        //     ),
        //     bottom: BorderSide(color: Colors.white),
        //     right: BorderSide(color: Colors.white),
        //     left: BorderSide(color: Color(0xff61ff8d), width: 5),
        //   ),
        // ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order delivered
                Text(widget.title,
                    style: const TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontFamily: "SFUIText",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                // Your order has been delivered. Kindly rate us on Play store or App Store
                // Text(widget.description,
                //     style: notificationStyle, textAlign: TextAlign.left),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order type : ",
                            style: notificationStyle,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text("Time : ",
                              style: notificationStyle,
                              textAlign: TextAlign.left),
                        ),
                        Text("No:of Guests : ",
                            style: notificationStyle,
                            textAlign: TextAlign.left),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.type,
                            style: notificationStyle,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(widget.time,
                              style: notificationStyle,
                              textAlign: TextAlign.left),
                        ),
                        Text(widget.noOfGuests,
                            style: notificationStyle,
                            textAlign: TextAlign.left),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .26,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          markDone(1);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.1))),
                        ),
                        child: Text(
                          "Reject",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .26,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          markDone(0);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.1))),
                        ),
                        child: Text(
                          "Approve",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
