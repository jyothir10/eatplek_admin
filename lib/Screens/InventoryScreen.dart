import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  static const String id = '/invent';
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  bool expanded = false;
  bool setFries = false;
  List<bool> fries = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashboardScreen.id);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * .107),
            child: AppBar(
              backgroundColor: Color(0xff042e60),
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, DashboardScreen.id);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                ),
              ),
              title: const Text(
                'Inventory',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.search_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xfff0ecec),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Out of stock items',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (expanded == true) {
                                    expanded = false;
                                  } else {
                                    expanded = true;
                                  }
                                });
                              },
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
                expanded
                    ? Container(
                        height: MediaQuery.of(context).size.height * .07,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xfff3f3f3),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Biriyani',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                  Text(
                                    '₹ 160',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Biriyani',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                  Text(
                                    '₹ 160',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          setFries
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_right_outlined,
                          size: 18,
                          color: setFries ? Colors.black : Color(0x7f000000),
                        ),
                        Text(
                          'Fries',
                          style: TextStyle(
                            color: setFries ? Colors.black : Color(0x7f000000),
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: setFries,
                      onChanged: (value) {
                        setState(() {
                          setFries = value;
                        });
                      },
                      activeColor: Color(0xffffb800),
                      activeTrackColor: Color(0xfff0ecec),
                    ),
                  ],
                ),
                setFries
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            InventoryItems(
                              selected: fries[0],
                              name: "Plain Fries",
                              rate: "₹ 60",
                            ),
                            InventoryItems(
                              selected: fries[1],
                              name: "Masala Fries",
                              rate: "₹ 160",
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(
            index: 1,
          ),
        ),
      ),
    );
  }
}

class InventoryItems extends StatefulWidget {
  bool selected;
  String name;
  String rate;
  InventoryItems({
    Key? key,
    required this.selected,
    required this.name,
    required this.rate,
  }) : super(key: key);

  @override
  State<InventoryItems> createState() => _InventoryItemsState();
}

class _InventoryItemsState extends State<InventoryItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.selected ? Colors.black : Color(0x7f000000),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.circle,
                size: 5,
                color: widget.selected ? Colors.black : Color(0x7f000000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: widget.selected ? Colors.black : Color(0x7f000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              widget.rate,
              style: TextStyle(
                color: widget.selected ? Colors.black : Color(0x7f000000),
                fontSize: 10,
                fontFamily: 'SFUIText',
              ),
            ),
            Switch(
              value: widget.selected,
              onChanged: (value) {
                setState(() {
                  widget.selected = value;
                });
              },
              activeColor: Color(0xffffb800),
              activeTrackColor: Color(0xfff0ecec),
            ),
          ],
        )
      ],
    );
  }
}
