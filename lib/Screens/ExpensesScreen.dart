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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Orders',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
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
                        children: const [
                          Text(
                            'Vinod Kumar ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              '₹ 520',
                              style: TextStyle(
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
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          index: 2,
        ),
      ),
    );
  }
}
