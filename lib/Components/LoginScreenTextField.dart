import 'package:flutter/material.dart';

class LoginScreenTextField extends StatelessWidget {
  final String text;
  final void Function(String)? onchanged;
  final TextInputType type;
  final bool obscure;
  final TextEditingController controller;

  const LoginScreenTextField({
    Key? key,
    required this.text,
    required this.onchanged,
    required this.type,
    required this.obscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .752,
      height: MediaQuery.of(context).size.height * .053,
      child: TextField(
        obscureText: obscure,
        onChanged: onchanged,
        keyboardType: type,
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xff042e60),
          fontFamily: 'SFUIText',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          filled: true,
          fillColor: const Color(0xf3ffffff),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
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
