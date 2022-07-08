import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: (const TabBar(
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'SFUIText',
              ),
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Preparing",
                ),
                Tab(
                  text: "Delivered",
                ),
                Tab(
                  text: "Delay",
                ),
              ],
            )),
          ),
        ));
  }
}
