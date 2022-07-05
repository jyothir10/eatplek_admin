import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = '/notifi';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffececec),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
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
        body: Center(
          child: Container(
            color: Color(0xffececec),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .885,
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.white,
                        ),
                        bottom: BorderSide(color: Colors.white),
                        right: BorderSide(color: Colors.white),
                        left: BorderSide(color: Color(0xff61ff8d), width: 5),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // Order delivered
                            Text("Order delivered",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                textAlign: TextAlign.left),
                            // Your order has been delivered. Kindly rate us on Play store or App Store
                            Text(
                                "Your order has been delivered. Kindly rate us on Play store\n or App Store",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .885,
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7F7F7),
                      border: Border(
                        top: BorderSide(
                            color: Color(0xffececec)
                        ),
                        bottom: BorderSide(color: Color(0xffececec)),
                        right: BorderSide(color: Color(0xffececec)),
                        left: BorderSide(color: Color(0xff61ff8d), width: 5),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: const Color(0xffF7F7F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // Order delivered
                            Text("Order delivered",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                textAlign: TextAlign.left),
                            // Your order has been delivered. Kindly rate us on Play store or App Store
                            Text(
                                "Your order has been delivered. Kindly rate us on Play store \nor App Store",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .885,
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7F7F7),
                      border: Border(
                        top: BorderSide(
                            color: Color(0xffececec)
                        ),
                        bottom: BorderSide(color: Color(0xffececec)),
                        right: BorderSide(color: Color(0xffececec)),
                        left: BorderSide(color: Color(0xff61ff8d), width: 5),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: const Color(0xffF7F7F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // Order delivered
                            Text("Order delivered",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                textAlign: TextAlign.left),
                            // Your order has been delivered. Kindly rate us on Play store or App Store
                            Text(
                                "Your order has been delivered. Kindly rate us on Play store \nor App Store",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
