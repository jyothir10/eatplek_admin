import 'package:flutter/material.dart';

class PlainButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const PlainButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffffffff)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.1))),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0x59000000),
          fontSize: 13,
          fontFamily: 'SFUIText',
        ),
      ),
    );
  }
}
