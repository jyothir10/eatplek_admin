import 'package:flutter/material.dart';

class MenuChangeScreen extends StatefulWidget {
  static const String id = '/MenuChange';
  const MenuChangeScreen({Key? key}) : super(key: key);

  @override
  State<MenuChangeScreen> createState() => _MenuChangeScreenState();
}

class _MenuChangeScreenState extends State<MenuChangeScreen> {
  bool expanded1 = false;
  bool expanded2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff1A191A),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Menu Change',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xfffff5f5),
            height: MediaQuery.of(context).size.height * .0475,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (expanded1 == true) {
                      expanded1 = false;
                    } else {
                      expanded1 = true;
                    }
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      expanded1
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_right_outlined,
                      size: 18,
                    ),
                    const Text(
                      'Adding New item',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.387463569641113,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          expanded1?Container(
            color: Colors.white,
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28),
                        child: Text(
                          'Rate',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: MediaQuery.of(context).size.width * .446,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Color(0xff8a8a8a),
                            fontSize: 10,
                            fontFamily: 'SFUIText',
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff17000000),
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Name of new item",
                            hintStyle: const TextStyle(
                              color: Color(0xff8a8a8a),
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            const Text(
                              'RS  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width * .1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff8a8a8a),
                                  fontSize: 12,
                                  fontFamily: 'SFUIText',
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff17000000),
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  hintText: "Rate",
                                  hintStyle: const TextStyle(
                                    color: Color(0xff8a8a8a),
                                    fontSize: 10,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width * .633,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Color(0xff8a8a8a),
                            fontSize: 10,
                            fontFamily: 'SFUIText',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            filled: true,
                            fillColor: Color(0xff17000000),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Short description",
                            hintStyle: const TextStyle(
                              color: Color(0xff8a8a8a),
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ):Container(
            height: 13,
          ),
          Container(
            color: Color(0xfffff5f5),
            height: MediaQuery.of(context).size.height * .0475,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (expanded2 == true) {
                      expanded2 = false;
                    } else {
                      expanded2 = true;
                    }
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      expanded2
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_right_outlined,
                      size: 18,
                    ),
                    const Text(
                      'Change Exisiting Iteam Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.387463569641113,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          expanded2?Container(
            color: Colors.white,
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28),
                        child: Text(
                          'Rate',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: MediaQuery.of(context).size.width * .446,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Color(0xff8a8a8a),
                            fontSize: 10,
                            fontFamily: 'SFUIText',
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff17000000),
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Name of item",
                            hintStyle: const TextStyle(
                              color: Color(0xff8a8a8a),
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            const Text(
                              'RS  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width * .1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff8a8a8a),
                                  fontSize: 12,
                                  fontFamily: 'SFUIText',
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff17000000),
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  hintText: "Rate",
                                  hintStyle: const TextStyle(
                                    color: Color(0xff8a8a8a),
                                    fontSize: 10,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width * .633,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Color(0xff8a8a8a),
                            fontSize: 10,
                            fontFamily: 'SFUIText',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            filled: true,
                            fillColor: Color(0xff17000000),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Short description",
                            hintStyle: const TextStyle(
                              color: Color(0xff8a8a8a),
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ):Container(
          ),
        ],
      ),
    ));
  }
}
