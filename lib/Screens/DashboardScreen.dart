import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Components/DashBoardCard.dart';
import 'package:eatplek_admin/Components/YellowButton.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomBar(
            index: 0,
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff042e60),
            title: const Text(
              'Order Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.597015380859375,
                fontFamily: 'SFUIText',
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(125),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .943,
                    decoration: BoxDecoration(
                      color: Color(0x23ffffff),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'The Smocky Shack',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Chengannur',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              YellowButton(text: "Open", onTap: () {}),
                              Padding(
                                padding: const EdgeInsets.only(left: 7, top: 7),
                                child: InkWell(
                                  onTap: () {
                                    //todo:change
                                  },
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            color: Colors.white,
                                            offset: Offset(0, -5))
                                      ],
                                      color: Colors.transparent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0x23ffffff),
                                      decorationThickness: 5,
                                      fontSize: 6,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  (const TabBar(
                    indicatorColor: Color(0xff59f5ff),
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
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DashBoardCard(
                        name: "Vinod Kumar",
                        time: '10:00 AM',
                        date: '21-10-2022',
                        guest: "3",
                        phone: '9865123548',
                        isDelivered: false,
                      ),
                      DashBoardCard(
                        name: "Vinod Kumar",
                        time: '10:00 AM',
                        date: '21-10-2022',
                        guest: "3",
                        phone: '9865123548',
                        isDelivered: false,
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}