import 'package:flutter/material.dart';

class LoginScreenTextField extends StatelessWidget {
  final String text;
  final void Function(String)? onchanged;
  final TextInputType type;
  final bool obscure;

  const LoginScreenTextField({
    Key? key,
    required this.text,
    required this.onchanged,
    required this.type,
    required this.obscure
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .752,
      height: MediaQuery.of(context).size.height * .053,
      decoration: BoxDecoration(
        color: const Color(0xf3ffffff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        obscureText: obscure,
        onChanged: onchanged,
        keyboardType: type,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0x89042e60),
          fontFamily: 'SFUIText',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          hintStyle: const TextStyle(
            color: Color(0x89042e60),
            fontFamily: 'SFUIText',
          ),
        ),
      ),
    );
  }
}