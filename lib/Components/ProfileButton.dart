import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ProfileButton({
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
        MaterialStateProperty.all<Color>(const Color(0xff042e60)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7),),),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'SFUIText',
        ),
      ),
    );
  }
}
