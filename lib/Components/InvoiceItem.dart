import 'package:flutter/material.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Zinger Burger",
                style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 10.0),
                textAlign: TextAlign.left), // Zinger Burger
            Text("179",
                style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 10.0),
                textAlign: TextAlign.left), // 179
            Text("1",
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 10.0),
                textAlign: TextAlign.left), // 1
            Text("179",
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 10.0),
                textAlign: TextAlign.left) // 179
          ],
        ),
        const Divider(
          color: Color(0xff1c042e60),
          thickness: 1,
        ),
      ],
    );
  }
}
