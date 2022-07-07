import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const BlueButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .41,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff042e60)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.1))),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'SFUIText',
          ),
        ),
      ),
    );
  }
}
