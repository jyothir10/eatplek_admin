import 'dart:convert';
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/InvoiceListItem.dart';

class InvoiceScreen extends StatefulWidget {
  static const String id = '/invoice';
  String orderId = "";

  InvoiceScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool showSpinner = true;
  var cart, user, data;
  String resname = "",
      userPhone = "",
      name = "",
      resPhone = "",
      location = "",
      time = "",
      date = "";
  List items = [];
  int totalAmount = 0, n = 10;
  String formattedDate = "";

  getOrderDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? resid = sharedPreferences.getString("id");
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/order/${widget.orderId}');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      data = await jsonData['result'];
      cart = await jsonData['result']['cart'];
      user = await jsonData['result']['user'];

      resname = cart['restaurant_name'];
      items = cart['items'];
      n = items.length;
      totalAmount = cart['total_amount'];
      time = cart['time'];
      name = user['name'];
      userPhone = user['phone'];
      resPhone = data['restaurant']['phone'];
      location = data['restaurant']['location'];

      DateTime d = DateTime.parse(data["created_at"]);

      var formatter = new DateFormat('dd-MM-yyyy');
      formattedDate = formatter.format(d);

      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getOrderDetails();
    // NotificationApi.init();
    // listenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: // Your Order
            const Text("Invoice",
                style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                textAlign: TextAlign.left),
        backgroundColor: Colors.white,
        elevation: 0,
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
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: primaryClr,
        ),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .90,
                width: MediaQuery.of(context).size.width * .925,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 35,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      // Bill to:
                                      const Text("Bill to: ",
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SFUIText",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.0),
                                          textAlign: TextAlign.left),
                                      // Sreerag N
                                      Text(name,
                                          style: const TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "SFUIText",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // Phone:
                                      const Text("Phone: ",
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SFUIText",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.0),
                                          textAlign: TextAlign.left),
                                      // 9746800150
                                      Text(userPhone,
                                          style: const TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "SFUIText",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.0),
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: primaryClr,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * .068,
                              width: MediaQuery.of(context).size.width * .31,
                              child: const Center(
                                child: Text("INVOICE",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0),
                                    textAlign: TextAlign.left),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Text(resname,
                                  style: const TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(location+" ",
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFUIText",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 9.0),
                                        textAlign: TextAlign.left),
                                    // 9854654213
                                    Text(resPhone,
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFUIText",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 9.0),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              ), // Chengannur,
                            ],
                          ),
                        ), // Ceylon Bake House Marian Drive
                        const DottedLine(
                          direction: Axis.horizontal,
                          dashColor: Color(0xff23000000),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Item",
                                      style: invoiceStyle,
                                      textAlign: TextAlign.left), // Item
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .17),
                                    child: const Text("Unit Price",
                                        style: invoiceStyle,
                                        textAlign: TextAlign.left),
                                  ), // Unit Price
                                  const Text("Quantity",
                                      style: invoiceStyle,
                                      textAlign: TextAlign.left), // Quantity
                                  const Text("Total",
                                      style: invoiceStyle,
                                      textAlign: TextAlign.left), // Total
                                ],
                              ),
                              const Divider(
                                color: Color(0xff1c042e60),
                                thickness: 1,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    n *
                                    .033,
                                width: MediaQuery.of(context).size.width * .925,
                                child: items.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: n,
                                        itemBuilder: (context, index) {
                                          return InvoiceListItem(
                                              itemName: items[index]['name'],
                                              price: items[index]['price']
                                                  .toString(),
                                              qty: items[index]['quantity']
                                                  .toString(),
                                              total: items[index]['total']
                                                  .toString());
                                        })
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Taxes and Charges",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 8.0),
                                  textAlign:
                                      TextAlign.left), // Taxes and Charges
                              Text("₹ 0.0",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 8.0),
                                  textAlign: TextAlign.left), // ₹ 53.2
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, top: 9, bottom: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Total Price: Rs ",
                                  style: TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0),
                                  textAlign: TextAlign.left),
                              Text(totalAmount.toString(),
                                  style: const TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0),
                                  textAlign:
                                      TextAlign.left), // Total Price: Rs 818/-
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("THANK YOU",
                              style: TextStyle(
                                  letterSpacing: 5,
                                  color: primaryClr,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0),
                              textAlign: TextAlign.left),
                        ), // THANK YOU
                        Container(
                          color: primaryClr,
                          height: MediaQuery.of(context).size.height * .038,
                          width: MediaQuery.of(context).size.width * .925,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text("Billing Date: ",
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left),
                                  Text(formattedDate,
                                      style: const TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left), // 10/02/2022
                                ],
                              ), // Billing Date:
                              Row(
                                children: [
                                  const Text("Billing Time: ",
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left),
                                  Text(time,
                                      style: const TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left), // 10:00 AM
                                ],
                              ), // Billing Time:
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
