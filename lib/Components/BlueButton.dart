import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  double? fontSize = 13;
  final void Function()? onTap;
  BlueButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff042e60)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.1))),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontFamily: 'SFUIText',
        ),
      ),
    );
  }
}
