import 'package:eatplek_admin/Components/BlueButton.dart';
import 'package:flutter/material.dart';

class DashBoardCard extends StatefulWidget {
  bool isExpanded = false;
  double n = 3;
  bool isDelivered;
  final String name;
  final String date;
  final String phone;
  final String time;
  final String guest;

  DashBoardCard({
    Key? key,
    required this.name,
    required this.time,
    required this.date,
    required this.guest,
    required this.phone,
    required this.isDelivered,
  }) : super(key: key);

  @override
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: widget.isExpanded == false ? 231 : (231 + (widget.n * 15)),
        width: MediaQuery.of(context).size.width * .932,
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.phone,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'SFUIText',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'No of Guests : ${widget.guest}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                ],
              ),
              Container(
                height:
                    widget.isExpanded == false ? 89 : (89 + (widget.n * 15)),
                width: MediaQuery.of(context).size.width * .83,
                decoration: BoxDecoration(
                  color: Color(0x56e0e0e0),
                  border: Border.all(
                    color: Color(0x19000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Image.asset("images/index.png"),
                              ),
                              Text(
                                'Zinger Burger',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '₹ 250',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 7),
                            child: widget.isExpanded == false
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.isExpanded = true;
                                      });
                                    },
                                    child: Text(
                                      '+3 more',
                                      style: TextStyle(
                                        color: Color(0xff284aff),
                                        fontSize: 8,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '₹ 540',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isDelivered == true
                        ? const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              'View Bill',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Color(0xff284aff),
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 8,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xff284aff),
                                decorationThickness: 5,
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .2136,
                            child: BlueButton(
                                text: "Mark Done",
                                fontSize: 10.75,
                                onTap: () {
                                  //todo: mark as done
                                  setState(() {
                                    widget.isDelivered = true;
                                  });
                                }),
                          ),
                    widget.isDelivered == true
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'View Bill',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Color(0xff284aff),
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                fontSize: 8,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xff284aff),
                                decorationThickness: 5,
                              ),
                            ),
                          ),
                    widget.isDelivered == true
                        ? Row(
                            children: const [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 20,
                                color: Color(0xff00D823),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Delivered',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.745818138122559,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Color(0xffffb800),
                                radius: 10,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Icon(
                                    Icons.minimize,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Preparing',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.745818138122559,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
