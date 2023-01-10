import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/NotificationCard.dart';
import '../Constants.dart';
import '../Exceptions/api_exception.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var notifications = [];
  bool isEmpty1 = false;
  bool showList1 = false;
  bool showSpinner = true;
  static const except = {'exc': 'An error occured'};

  getNotifications() async {
    setState(() {
      showSpinner = true;
    });
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? token = sharedpreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/requests');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['requests'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else if (jsonData['requests'] == 0) {
        isEmpty1 = true;
        showList1 = true;
      } else {
        notifications = await jsonData['requests'];
        print(notifications);
        showList1 = true;
      }
    } else {
      isEmpty1 = true;
      showList1 = true;
      APIException(response.statusCode, except);
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffececec),
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
        title: const Text("Notifications",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
                fontFamily: "SFUIText",
                fontStyle: FontStyle.normal,
                fontSize: 14.0),
            textAlign: TextAlign.left),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: primaryClr,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: showList1 == true
                  ? Container(
                      color: Color(0xffececec),
                      height: MediaQuery.of(context).size.height - 70,
                      width: MediaQuery.of(context).size.width,
                      child: isEmpty1 == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: ListView.builder(
                                  itemCount: notifications.length,
                                  itemBuilder: (context, index) {
                                    return NotificationCard(
                                      title: "Order Request",
                                      time: notifications[index]['time']
                                          .toString(),
                                      type: notifications[index]['type']
                                          .toString(),
                                      noOfGuests: notifications[index]
                                              ['number_of_guests']
                                          .toString(),
                                      description: "",
                                      userId: notifications[index]['user_id']
                                          .toString(),
                                      onTap: () {
                                        getNotifications();
                                      },
                                    );
                                  }),
                            )
                          : Center(child: Text("No new notifications")),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("Fetching notifications")),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
