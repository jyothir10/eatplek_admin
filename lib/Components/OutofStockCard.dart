import 'package:flutter/material.dart';

class OutofStockCard extends StatelessWidget {
  String item;
  String price;
  OutofStockCard({
    Key? key,
    required this.item,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'SFUIText',
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'SFUIText',
            ),
          ),
        ],
      ),
    );
  }
}
