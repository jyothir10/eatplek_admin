import 'package:dotted_line/dotted_line.dart';
import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';

import '../Components/InvoiceItem.dart';

class InvoiceScreen extends StatefulWidget {
  static const String id = '/invoice';
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    super.initState();
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .48,
              width: MediaQuery.of(context).size.width * .925,
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
                                children: const [
                                  // Bill to:
                                  Text("Bill to: ",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left),
                                  // Sreerag N
                                  Text(" Sreerag N",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                              Row(
                                children: const [
                                  // Phone:
                                  Text("Phone: ",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left),
                                  // 9746800150
                                  Text(" 9746800150",
                                      style: TextStyle(
                                          color: const Color(0xff000000),
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
                    Column(
                      children: [
                        const Text("Ceylon Bake House Marian Drive",
                            style: TextStyle(
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
                            children: const [
                              Text("Chengannur, ",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 9.0),
                                  textAlign: TextAlign.left),
                              // 9854654213
                              Text("9854654213",
                                  style: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Item",
                                  style: TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left), // Item
                              Text("Unit Price",
                                  style: TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left), // Unit Price
                              Text("Quantity",
                                  style: const TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left), // Quantity
                              Text("Total",
                                  style: const TextStyle(
                                      color: primaryClr,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left), // Total
                            ],
                          ),
                          const Divider(
                            color: Color(0xff1c042e60),
                            thickness: 1,
                          ),
                          InvoiceItem(),
                          InvoiceItem(),
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
                              textAlign: TextAlign.left), // Taxes and Charges
                          Text("₹ 53.2",
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
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("Total Price: Rs ",
                              style: TextStyle(
                                  color: primaryClr,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0),
                              textAlign: TextAlign.left),
                          Text("818/-",
                              style: TextStyle(
                                  color: primaryClr,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0),
                              textAlign:
                                  TextAlign.left), // Total Price: Rs 818/-
                        ],
                      ),
                    ),
                    const Text("THANK YOU",
                        style: TextStyle(
                            letterSpacing: 5,
                            color: primaryClr,
                            fontWeight: FontWeight.w900,
                            fontFamily: "SFUIText",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0),
                        textAlign: TextAlign.left), // THANK YOU
                    Container(
                      color: primaryClr,
                      height: MediaQuery.of(context).size.height * .038,
                      width: MediaQuery.of(context).size.width * .925,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: const [
                              Text("Billing Date: ",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left),
                              Text("10/02/2022",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left), // 10/02/2022
                            ],
                          ), // Billing Date:
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Text("Billing Time: ",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0),
                                    textAlign: TextAlign.left),
                                Text("10:00 AM",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0),
                                    textAlign: TextAlign.left), // 10:00 AM
                              ],
                            ),
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
    );
  }
}
