import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';

class InvoiceListItem extends StatelessWidget {
  String itemName, price, qty, total;

  InvoiceListItem({
    required this.itemName,
    required this.price,
    required this.qty,
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .21,
              child: Text(itemName,
                  style: invoiceListStyle, textAlign: TextAlign.left),
            ), // Zinger Burger
            Text(price,
                style: invoiceListStyle, textAlign: TextAlign.left), // 179
            Text(qty, style: invoiceListStyle, textAlign: TextAlign.left), // 1
            Text(total,
                style: invoiceListStyle, textAlign: TextAlign.left) // 179
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
