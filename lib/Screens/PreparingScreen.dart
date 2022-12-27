import 'dart:convert';

import 'package:eatplek_admin/Components/DashBoardCard.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';
import 'InvoiceScreen.dart';

class PreparingScreen extends StatefulWidget {
  const PreparingScreen({Key? key}) : super(key: key);

  @override
  State<PreparingScreen> createState() => _PreparingScreenState();
}

class _PreparingScreenState extends State<PreparingScreen> {
  bool isEmpty1 = false;
  bool showList1 = false;
  List orders = [];
  List preparingOrders = [];
  int i = 0;
  static const except = {'exc': 'An error occured'};

  getOrders() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String? id = sharedpreferences.getString("id");
    String? token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal =
        Uri.https(URL_Latest, '/order/filter/restaurant/$id'); //todo:change id.

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      orders = await jsonData['result'];

      if (jsonData['result'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else {
        for (i = 0; i < orders.length; i++) {
          if (orders[i]['status'] == -1) {
            preparingOrders.add(orders[i]);
          }
        }
        if (preparingOrders.length == 0) {
          isEmpty1 = true;
          showList1 = true;
        }
        showList1 = true;
      }
      setState(() {});
    } else {
      isEmpty1 = true;
      showList1 = true;
      APIException(response.statusCode, except);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: showList1 == true
          ? SingleChildScrollView(
              child: Container(
                height: 500, //todo: height
                child: isEmpty1 == false
                    ? StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 5)).asyncMap(
                            (i) =>
                                getOrders()), // i is null here (check periodic docs)
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemCount: preparingOrders.length,
                              itemBuilder: (context, index) {
                                DateTime d = DateTime.parse(
                                    preparingOrders[index]["created_at"]);

                                var formatter = new DateFormat('dd-MM-yyyy');
                                String formattedDate = formatter.format(d);
                                return DashBoardCard(
                                  name: preparingOrders[index]['user']['name'],
                                  time: preparingOrders[index]['cart']['time'],
                                  date: formattedDate,
                                  guest: preparingOrders[index]['cart']
                                          ['number_of_guests']
                                      .toString(),
                                  phone: preparingOrders[index]['user']
                                      ['phone'],
                                  isDelivered: orders[index]['status'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InvoiceScreen(
                                              orderId: orders[index]['id'])),
                                    );
                                  },
                                  orderId: orders[index]['id'],
                                );
                              });
                        } // builder should also handle the case when data is not fetched yet
                        )
                    : Container(
                        child: Center(
                          child: Text(
                            "No preparing orders",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
              ),
            )
          : Center(
              child: SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
            ),
    );
  }
}
