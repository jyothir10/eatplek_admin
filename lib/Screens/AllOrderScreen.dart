import 'dart:convert';

import 'package:eatplek_admin/Components/DashBoardCard.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:eatplek_admin/Screens/InvoiceScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  bool isEmpty1 = false;
  bool showList1 = false;
  bool isDelivered = false;
  List orders = [];
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
      } else if (orders.length == 0) {
        isEmpty1 = true;
        showList1 = true;
      } else {
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
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                DateTime d =
                                    DateTime.parse(orders[index]["created_at"]);

                                var formatter = new DateFormat('dd-MM-yyyy');
                                String formattedDate = formatter.format(d);

                                return DashBoardCard(
                                  name: orders[index]['user']['name'],
                                  time: orders[index]['cart']['time'],
                                  date: formattedDate,
                                  guest: orders[index]['cart']
                                          ['number_of_guests']
                                      .toString(),
                                  phone: orders[index]['user']['phone'],
                                  isDelivered: orders[index]['status'],
                                  orderId: orders[index]['id'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InvoiceScreen(
                                              orderId: orders[index]['id'])),
                                    );
                                  },
                                );
                              });
                        } // builder should also handle the case when data is not fetched yet
                        )
                    : Container(
                        child: Text("No orders"),
                      ),
              ),
            )
          : Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: primaryClr,
                  )),
            ),
    );
  }
}
