import 'package:flutter/material.dart';
import 'package:eatplek_admin/Components/LoginButton.dart';
import 'package:eatplek_admin/Components/LoginScreenTextField.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff042e60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image(
                      image: AssetImage("images/logo.png"),
                        width: MediaQuery.of(context).size.width * .717,
                        height: MediaQuery.of(context).size.height * .372,
                    )
                  : Container(),
              const Text(
                'Log in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                children: [
                  LoginScreenTextField(
                      text: "Username",
                      onchanged: (value) {},
                      type: TextInputType.name,
                      obscure: false),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: LoginScreenTextField(
                      text: "Password",
                      onchanged: (value) {},
                      type: TextInputType.name,
                      obscure: true,
                    ),
                  ),
                ],
              ),

              LoginButton(
                onPressed: () {},
                text: 'Get OTP',
              )
            ],
          ),
        ),
      ),
    );
  }
}
