import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const LoginButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .852,
      height: MediaQuery.of(context).size.height * .053,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xff042e60),
            fontSize: 18,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),

      ),
    );
  }
}
