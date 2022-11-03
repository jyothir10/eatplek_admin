import 'package:eatplek_admin/Constants.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController myController;
  final String text;
  final TextInputType type;
  const EditProfileTextField({
    Key? key,
    required this.myController,
    required this.text,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: editprofilestyle,
              ),
            ],
          ),
          TextField(
            controller: myController,
            keyboardType: type,
            cursorColor: const Color(0x80000000),
            onChanged: (text) {},
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x80000000)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x80000000)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
