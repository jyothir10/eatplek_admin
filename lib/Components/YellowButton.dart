import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const YellowButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .19,
      height: 19,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffffb800)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.1))),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.5,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
