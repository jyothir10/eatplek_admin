import 'dart:convert';

import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardCard extends StatefulWidget {
  bool isExpanded = false;
  double n = 3;
  int isDelivered;
  final String name;
  final String date;
  final String phone;
  final String time;
  final String guest;
  final String orderId;
  void Function() onTap;

  DashBoardCard({
    Key? key,
    required this.name,
    required this.time,
    required this.date,
    required this.guest,
    required this.phone,
    required this.isDelivered,
    required this.onTap,
    required this.orderId,
  }) : super(key: key);

  @override
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard> {
  markDone() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    Map body1 = {"id": widget.orderId, "status": 0};

    final body = jsonEncode(body1);
    var urlfinal = Uri.https(URL_Latest, '/order/status');

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: widget.isExpanded == false ? 190 : (235 + (widget.n * 16)),
        width: MediaQuery.of(context).size.width * .932,
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.3),
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.phone,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'No of Guests : ${widget.guest}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isDelivered == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: InkWell(
                              onTap: widget.onTap,
                              child: const Text(
                                'View Bill',
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: Color(0xff284aff),
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  fontSize: 11,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff284aff),
                                  decorationThickness: 5,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .25,
                            height: 29,
                            child: BlueButton(
                                text: "Mark Done",
                                fontSize: 10.75,
                                onTap: () {
                                  markDone();
                                  setState(() {
                                    widget.isDelivered = 0;
                                  });
                                }),
                          ),
                    widget.isDelivered == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: widget.onTap,
                              child: const Text(
                                'View Bill',
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: Color(0xff284aff),
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  fontSize: 8,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff284aff),
                                  decorationThickness: 5,
                                ),
                              ),
                            ),
                          ),
                    widget.isDelivered == 0
                        ? Row(
                            children: const [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 20,
                                color: Color(0xff00D823),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Delivered',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.745818138122559,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Color(0xffffb800),
                                radius: 10,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Icon(
                                    Icons.minimize,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Preparing',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.745818138122559,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
