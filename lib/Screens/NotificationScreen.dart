import 'package:flutter/material.dart';

import '../Components/NotificationCard.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = '/notifi';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
      body: SafeArea(
        child: Center(
          child: Container(
            color: Color(0xffececec),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                NotificationCard(
                  title: "Order Request",
                  type: 'Dine-in',
                  noOfGuests: '3',
                  time: '3 Sep 2023 10:45',
                  description: 'This is description',
                  userId: "wtrthtyik646754vb",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
