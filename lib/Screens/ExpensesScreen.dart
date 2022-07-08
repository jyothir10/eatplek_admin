import 'package:flutter/material.dart';
import 'package:eatplek_admin/Components/BottomBar.dart';
import 'dart:math' as math;

class ExpensesScreen extends StatefulWidget {
  static const String id = '/expenses';
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff042e60),
          title: const Text(
            'Expenses',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xff72dd83),
            labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(
                text: "By Day",
              ),
              Tab(
                text: "By Week",
              ),
              Tab(
                text: "By Month",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .084,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: Color(0xffe6e6e6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  'Today’s Revenue',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 7.849205017089844,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                                Text(
                                  '₹ 4500',
                                  style: TextStyle(
                                    color: Color(0xff1d1d1d),
                                    fontSize: 18.838092803955078,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'Total number\n    of orders',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 6.906872272491455,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                                Text(
                                  '14',
                                  style: TextStyle(
                                    color: Color(0xff1d1d1d),
                                    fontSize: 13.81374454498291,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const ExpenseScreenCard(
                      name: 'Vinod Kumar ',
                      price: '₹ 520',
                    ),
                    const ExpenseScreenCard(
                      name: 'Vinod Kumar ',
                      price: '₹ 520',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .084,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: Color(0xffe6e6e6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  'Today’s Revenue',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 7.849205017089844,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                                Text(
                                  '₹ 4500',
                                  style: TextStyle(
                                    color: Color(0xff1d1d1d),
                                    fontSize: 18.838092803955078,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'Total number\n    of orders',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 6.906872272491455,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                                Text(
                                  '14',
                                  style: TextStyle(
                                    color: Color(0xff1d1d1d),
                                    fontSize: 13.81374454498291,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const ExpenseScreenCard(
                      name: 'Vinod Kumar ',
                      price: '₹ 520',
                    ),
                    const ExpenseScreenCard(
                      name: 'Vinod Kumar ',
                      price: '₹ 520',
                    ),
                  ],
                ),
              ),
            ),
            Container(),
          ],
        ),
        bottomNavigationBar: BottomBar(
          index: 2,
        ),
      ),
    );
  }
}

class ExpenseScreenCard extends StatelessWidget {
  final String name;
  final String price;

  const ExpenseScreenCard({
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: MediaQuery.of(context).size.height * .064,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: Color(0xffe6e6e6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    '2 items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: 270 * math.pi / 180,
                    child: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.black,
                      size: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
