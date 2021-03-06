import 'package:eatplek_admin/Constants.dart';
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
  String dropdownvalue = "item1";
  var items = ['item1', 'item2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MediaQuery.of(context).viewInsets.bottom == 0
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (expanded1 == true) {
                          expanded1 = false;
                        } else {
                          expanded1 = true;
                        }
                      });
                    },
                    child: Container(
                      color: Color(0xfffff5f5),
                      height: MediaQuery.of(context).size.height * .0475,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
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
                                fontSize: 14,
                                fontFamily: 'SFUIText',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            expanded1
                ? Container(
                    color: Colors.white,
                    height: 193,
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
                                    fontSize: 13,
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
                                    fontSize: 13,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * .49,
                                child: TextField(
                                  cursorColor: primaryClr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
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
                                      fontSize: 12,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    const Text(
                                      'RS  ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        cursorColor: primaryClr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: 'SFUIText',
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xff17000000),
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "Rate",
                                          hintStyle: const TextStyle(
                                            color: Color(0xff8a8a8a),
                                            fontSize: 12,
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
                                  cursorColor: primaryClr,
                                  style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'SFUIText',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 5, right: 3),
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
                                      fontSize: 12,
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
                  )
                : Container(
                    height: 13,
                  ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (expanded2 == true) {
                    expanded2 = false;
                  } else {
                    expanded2 = true;
                  }
                });
              },
              child: Container(
                color: Color(0xfffff5f5),
                height: MediaQuery.of(context).size.height * .0475,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        expanded2
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_right_outlined,
                        size: 18,
                      ),
                      const Text(
                        'Change Exisiting Item Details',
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
            expanded2
                ? Container(
                    color: Colors.white,
                    height: 193,
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
                                    fontSize: 13,
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
                                    fontSize: 13,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * .49,
                                decoration: BoxDecoration(
                                  color: Color(0xff17000000),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DropdownButton(
                                        hint: const Text(
                                          'Name of item',
                                          style: TextStyle(
                                            color: Color(0xff8a8a8a),
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                          ),
                                        ),
                                        value: dropdownvalue,
                                        iconSize: 18,
                                        iconEnabledColor: Color(0xff8a8a8a),
                                        iconDisabledColor: Color(0xff8a8a8a),
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: 'SFUIText',
                                        ),
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownvalue = value!;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    const Text(
                                      'RS  ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: 'SFUIText',
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xff17000000),
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "Rate",
                                          hintStyle: const TextStyle(
                                            color: Color(0xff8a8a8a),
                                            fontSize: 12,
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'SFUIText',
                                    height: 1.5,
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
                                      fontSize: 12,
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
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
